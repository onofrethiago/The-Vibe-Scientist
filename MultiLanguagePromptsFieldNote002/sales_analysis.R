library(ggplot2)
library(dplyr)
library(zoo)

# Generate synthetic dataset
set.seed(42)
df <- data.frame(
  Date = seq(as.Date("2018-01-01"), by = "month", length.out = 100),
  Sales = round(runif(100, 100, 500) + (1:100) * 2)
)

# Calculate 3-month moving average
df <- df %>%
  mutate(MA3 = rollapply(Sales, width = 3, FUN = mean, fill = NA, align = "right"))

# Visualization
ggplot(df, aes(x = Date, y = Sales)) +
  geom_point(color = "#0077b6", alpha = 0.6, size = 3) +
  geom_line(aes(y = MA3), color = "#d62828", size = 1.25) +
  labs(
    title = "Monthly Sales Analysis",
    subtitle = "Sales Volume with 3-Month Moving Average",
    x = "Date",
    y = "Sales Volume"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.line = element_line(size = 0.8, color = "#333333"),
    plot.title = element_text(face = "bold", size = 18, color = "#333333"),
    legend.position = "none"
  )
