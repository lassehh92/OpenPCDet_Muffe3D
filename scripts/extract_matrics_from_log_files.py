import os
import re
import pandas as pd

# Define the path to the directory containing the log files
log_directory = '/Users/lhh/Downloads/logs'

# Prepare regex patterns to extract required data
epoch_pattern = re.compile(r'EPOCH (\d+) EVALUATION')
recall_roi_pattern = re.compile(r'recall_roi_(0\.\d): (\d+\.\d+)')
recall_rcnn_pattern = re.compile(r'recall_rcnn_(0\.\d): (\d+\.\d+)')
avg_pred_num_objects_pattern = re.compile(r'Average predicted number of objects\(\d+ samples\): (\d+\.\d+)')

# Prepare a list to collect data
data = []

# Walk through the directory and read each log file
for root, dirs, files in os.walk(log_directory):
    for file in files:
        if file.endswith(".log"):  # Adjust the extension based on your log files
            file_path = os.path.join(root, file)
            with open(file_path, 'r') as log_file:
                content = log_file.read()
                
                # Extract data using regex
                epoch = epoch_pattern.search(content)
                recall_roi = recall_roi_pattern.findall(content)
                recall_rcnn = recall_rcnn_pattern.findall(content)
                avg_pred_num_objects = avg_pred_num_objects_pattern.search(content)

                # Construct a dictionary for each log file
                if epoch and recall_roi and recall_rcnn and avg_pred_num_objects:
                    record = {
                        'Epoch': int(epoch.group(1)),
                        'Average Predicted Number of Objects': float(avg_pred_num_objects.group(1))
                    }
                    for threshold, value in recall_roi:
                        record[f'Recall ROI {threshold}'] = float(value)
                    for threshold, value in recall_rcnn:
                        record[f'Recall RCNN {threshold}'] = float(value)

                    data.append(record)

# Create a DataFrame from the collected data
df = pd.DataFrame(data)

# Filter the DataFrame by specific epoch number
#filtered_df = df[df['Epoch'] == 50]

df = df.sort_values(by='Epoch', ascending=True)  # Set ascending=False for descending order


# Save the DataFrame to a CSV file
output_csv_path = '/Users/lhh/Downloads/logs/output_metrics.csv'
df.to_csv(output_csv_path, index=False)
print(f'Data successfully written to {output_csv_path}')
