import csv
import json

def read_csv(file_path):
    try:
        data = []
        with open(file_path, 'r') as csv_file:
            csv_reader = csv.DictReader(csv_file)
            for row in csv_reader:
                data.append(dict(row))
            print(f"File is successfully read",file_path)
        return data
    except FileExistsError as e:
        print("Error in file",file_path)
    except FileNotFoundError as e:
        print(f"File not found in {file_path}")

def create_csv(file_path, data):
    try:
        with open(file_path, 'w', newline='') as csv_file:
            csv_writer = csv.writer(csv_file)
            for row in data:
                csv_writer.writerow(row)
            print(f"File is successfully created at {file_path}")
    except Exception as e:
        print(e)

def read_csv_without_header(file_path):
    data = []
    with open(file_path, 'r') as csv_file:
        csv_reader = csv.reader(csv_file)
        for row in csv_reader:
            data.append(row)
    return data

def append_row_to_csv(file_path, row_data):
    with open(file_path, 'a', newline='') as csv_file:
        csv_writer = csv.writer(csv_file)
        csv_writer.writerow(row_data)