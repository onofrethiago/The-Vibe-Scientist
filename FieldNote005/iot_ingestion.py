import polars as pl
from pydantic import BaseModel, ConfigDict, Field, ValidationError
from datetime import datetime
from typing import List, Generator, Any
import gc

class SensorReading(BaseModel):
    """Strict schema mapping for Industrial IoT sensors."""
    model_config = ConfigDict(
        frozen=True,
        extra="forbid",
        str_strip_whitespace=True
    )
    
    timestamp: datetime
    sensor_id: str = Field(pattern=r"^SENS_[0-9]{3}$")
    value: float = Field(ge=-100.0, le=1000.0)  # Industrial physical range constraint
    unit: str

class EdgeDataPipeline:
    """Industrial IoT Edge ingestion engine (Restricted memory focus: < 2GB)."""
    
    def __init__(self, buffer_size: int = 10000):
        self._buffer_size = buffer_size

    def _validate_stream(self, raw_stream: Generator[dict, None, None]) -> Generator[dict, None, None]:
        """Lazy validation to keep memory heap low."""
        for raw_item in raw_stream:
            try:
                yield SensorReading(**raw_item).model_dump()
            except (ValidationError, TypeError):
                # Log telemetry drop in real production
                continue

    def ingest(self, source_stream: Generator[dict, None, None]):
        """Consumes sensor stream, aggregates, and flushes periodically."""
        # Using Polars streaming execution for out-of-core safety
        batch = []
        for validated_reading in self._validate_stream(source_stream):
            batch.append(validated_reading)
            
            if len(batch) >= self._buffer_size:
                self._flush_batch(batch)
                batch = []
                gc.collect()

        if batch:
            self._flush_batch(batch)

    def _flush_batch(self, batch_data: List[dict]):
        """Processes and sinks data using Polars Lazy API."""
        if not batch_data:
            return

        # Direct conversion to Polars DataFrame with explicit types
        df = pl.from_dicts(batch_data, schema={
            "timestamp": pl.Datetime,
            "sensor_id": pl.String,
            "value": pl.Float64,
            "unit": pl.String
        })

        # Efficient downscaling/aggregation
        aggregated_df = (
            df.lazy()
            .with_columns([
                pl.col("timestamp").dt.truncate("15m").alias("interval_15min")
            ])
            .group_by(["interval_15min", "sensor_id"])
            .agg([
                pl.col("value").mean().alias("v_avg"),
                pl.col("value").max().alias("v_max"),
                pl.col("value").min().alias("v_min")
            ])
            .collect(engine="streaming")
        )

        # Output to edge sink (e.g. encoded Parquet)
        print(f"Flushed batch: {aggregated_df.shape[0]} unique intervals")
        print(aggregated_df)
        del df
        del aggregated_df

def mock_sensor_data(n: int = 50000) -> Generator[dict, None, None]:
    """Generates synthetic high-frequency machinery telemetry."""
    for i in range(n):
        yield {
            "timestamp": datetime.now().isoformat(),
            "sensor_id": f"SENS_{ (i % 5):03d}",
            "value": float(20.0 + (i % 100) / 10.0),
            "unit": "C"
        }

if __name__ == "__main__":
    pipeline = EdgeDataPipeline(buffer_size=10000)
    pipeline.ingest(mock_sensor_data())
