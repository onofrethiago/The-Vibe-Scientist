# Field Note 005: Industrial IoT Data Ingestion Pipeline

This script implements a Memory-Efficient Industrial IoT Data Ingestion Pipeline optimized for edge devices with restricted RAM (under 2GB). Here’s a breakdown of its core components:

## 1. Strict Data Validation (`SensorReading`)
- **Pydantic V2**: Enforces strict typing, ensuring every sensor reading matches your defined schema (e.g., sensor_id must follow the SENS_XXX pattern).
- **Physical Range Constraints**: Validates that telemetry values stay within realistic industrial boundaries (e.g., -100 to 1000).
- **Immutability**: Uses `frozen=True` and `extra="forbid"` to prevent accidental data corruption or malformed JSON injections.

## 2. Low-Memory Ingestion (`EdgeDataPipeline`)
- **Lazy Streaming**: Instead of loading everything into memory, it processes data in small, manageable chunks (10,000 readings by default).
- **Memory Preservation**: Uses Python’s `gc.collect()` and explicit deletions to clear memory heaps promptly, maintaining a stable footprint even under LoRA-adapted constraints.

## 3. High-Performance Aggregation (Polars)
- **LazyFrame API**: It doesn't execute queries immediately. Instead, Polars builds an optimized execution plan.
- **Streaming Engine**: Uses `engine="streaming"` to process data that might exceed available RAM by performing out-of-core computations.
- **Downsampling**: Automatically groups incoming high-frequency data into 15-minute intervals, calculating the average, minimum, and maximum for each sensor.

## 4. Industrial Simulation
- **Mock Generator**: Simulates a live machine stream of 50,000 telemetry packets to demonstrate how the pipeline handles real-time pressure without crashing or memory-leaking.

---
© 2026 The Vibe Scientist™. All Rights Reserved.
