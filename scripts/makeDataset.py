import pandas as pd

gitRepo = 'https://raw.githubusercontent.com/owid/covid-19-data/master/'


dataset = ('public/data/vaccinations/vaccinations.csv',
           'public/data/vaccinations/vaccinations-by-manufacturer.csv',
           'public/data/vaccinations/vaccinations-by-age-group.csv',
           'public/data/vaccinations/us_state_vaccinations.csv',
           'public/data/vaccinations/locations.csv',
           'scripts/input/un/population_latest.csv',
           'scripts/input/iso/iso.csv',
           'public/data/vaccinations/country_data/Canada.csv')

# def download_file(file_path, local_filename='./covid-19-data/'):
#     response = requests.get(f'{gitRepo}{file_path}')
  
#     file_name = f'{local_filename}{file_path.split("/")[-1]}'
#     if response.status_code == 200:
#         # data =response.csv decode('utf8').split("\n")
#         # reader = csv.reader(data)
#         # for line in reader:
#         #     print(line)
        
#         with open("file_name.csv", 'wb') as file:
#             print(file_name)
#             file.write(response.content)
#         print(f"File downloaded successfully and saved as {file_name}")
#     else:
#         print(f"Failed to download file. HTTP Status Code: {response.status_code}, file: {file_name}")

def fetchGit(file):
    print(f"Fetching the data from github {file}")
    df = pd.read_csv(f"{gitRepo}{file}")
    df = df.fillna(0)
    records = df.to_dict('records')
    return records

def makeDataset():
    data = []
    for file in dataset:
        try:
            data.append(fetchGit(file))
            print(f"Successfully fetched the file {file}")
        except Exception as e:
            print(e)
            print(f"Unable to fetch the file {file}")

    return tuple(data)
    
    