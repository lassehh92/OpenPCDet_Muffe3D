import os

def replace_text_in_files(input_folder, output_folder):
    # Check if the output folder exists; if not, create it
    if not os.path.exists(output_folder):
        os.makedirs(output_folder)
    
    # Loop through all files in the input folder
    for filename in os.listdir(input_folder):
        # Only process .txt files
        if filename.endswith('.txt'):
            file_path = os.path.join(input_folder, filename)
            output_file_path = os.path.join(output_folder, filename)
            
            # Read the content of the file
            with open(file_path, 'r', encoding='utf-8') as file:
                content = file.read()
            
            # Replace 'Elbow' with 'Joint'
            updated_content = content.replace('Elbow', 'Joint')
            
            # Write the updated content to a new file in the output folder
            with open(output_file_path, 'w', encoding='utf-8') as file:
                file.write(updated_content)
            print(f'Processed {filename}')

if __name__ == "__main__":
    # Paths to the input and output folders
    txt_folder = '/Users/lhh/python-projects/CAD-to-3D-bbox-labels/muffe3d-v1/labels'
    output_folder_labels = '/Users/lhh/python-projects/CAD-to-3D-bbox-labels/muffe3d-3-classes-v1/labels'
    
    # Run the replacement function
    replace_text_in_files(txt_folder, output_folder_labels)
