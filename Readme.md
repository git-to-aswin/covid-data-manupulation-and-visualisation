## Covid Data Cleaning and Visualisation
Capturing the real time data of covid vaccine and we try to clean the data and build a schema for database. 

### The process covered in the project:
- Data cleaning and manpulation. Store the manpulated data in csv file
- Building of database schema and bring it to normalisation form
- Creating the database with the schema and insert the data into the table automatically from the csv
- Query the database and get the finding on the vaccination.
- Provide the finding in form of graph.

### Tools and Packages
- Pandas
- plotly

### Start the project
-   Create an environemnt
    - python -m venv ./venv
    - source venv/bin/activate
    - pip install -r requirements.txt
    - pip freeze > requirements.txt (if any new packet is added)
-   Starting file is in [scripts](./scripts/dataPipeline.ipynb)