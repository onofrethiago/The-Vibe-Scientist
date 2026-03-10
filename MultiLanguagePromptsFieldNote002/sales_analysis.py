import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Generate synthetic dataset
np.random.seed(42)
dates = pd.date_range(start='2018-01-01', periods=100, freq='M')
sales = np.random.randint(100, 500, size=100) + np.arange(100) * 2 
df = pd.DataFrame({'Date': dates, 'Sales': sales})

# Calculate 3-month moving average
df['MA3'] = df['Sales'].rolling(window=3).mean()

# Visualization
sns.set_theme(style="white")
plt.figure(figsize=(12, 6))

# Scatter plot
plt.scatter(df['Date'], df['Sales'], color='#0077b6', alpha=0.6, label='Monthly Sales', s=50)

# Moving average plot
plt.plot(df['Date'], df['MA3'], color='#d62828', linewidth=2.5, label='3-Month Moving Average')

# Aesthetic styling
plt.gca().spines['top'].set_visible(False)
plt.gca().spines['right'].set_visible(False)
plt.grid(False)
plt.title('Monthly Sales Analysis', fontsize=16, fontweight='bold', color='#333333')
plt.xlabel('Date', fontsize=12)
plt.ylabel('Sales Volume', fontsize=12)
plt.legend(frameon=False)

plt.tight_layout()
plt.show()
