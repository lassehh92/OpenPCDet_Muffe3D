import pandas as pd
import matplotlib.pyplot as plt

# Load the data from the CSV file
df = pd.read_csv('/Users/lhh/Downloads/logs/output_metrics.csv')

# Plot settings
plt.figure(figsize=(10, 8))
epochs = df['Epoch']
metrics = ['Recall ROI 0.3', 'Recall ROI 0.5', 'Recall ROI 0.7', 'Recall RCNN 0.3', 'Recall RCNN 0.5', 'Recall RCNN 0.7']
colors = ['blue', 'green', 'red', 'cyan', 'magenta', 'yellow']

# Plot each recall value on the same graph
for metric, color in zip(metrics, colors):
    plt.plot(epochs, df[metric], color=color, label=metric)

plt.title('Recall Values Over Epochs')
plt.xlabel('Epoch')
plt.ylabel('Recall')
plt.legend()
plt.grid(True)

# Show the plot
plt.show()
