def write_csv_sync(file_path, data):
    """
    Writes data to a CSV file synchronously without headers.

    :param file_path: Path to the CSV file
    :param data: List of strings containing the data to write
    """
    try:
        # Open the CSV file for writing
        with open(file_path, mode='w', encoding='utf-8') as csv_file:
            # Ensure unique rows and join them with newline characters
            unique_data = '\n'.join(set(data))
            # Write the data to the file
            csv_file.write(unique_data)
        print("Data has been written to file successfully.")
    except Exception as e:
        print(f"Error writing to file: {e}")
