
-- create Vaccine table
CREATE TABLE vaccine (
    vaccine TEXT NOT NULL
                 PRIMARY KEY
);                 

-- create Source table
CREATE TABLE source (
    source_name    TEXT,
    source_website TEXT,
    source_id      INTEGER PRIMARY KEY
);

-- create Age_group
CREATE TABLE age_group (
    age_group TEXT PRIMARY KEY NOT NULL
); 

-- create country
CREATE TABLE country (
    iso_code              TEXT NOT NULL,
    location              TEXT NOT NULL,
    source_id             TEXT,
    last_observation_date TEXT,
    FOREIGN KEY (source_id) REFERENCES source (source_id),
    PRIMARY KEY (iso_code)
);

-- create vaccine_used
CREATE TABLE country_vaccine (
    iso_code TEXT,
    vaccine TEXT,
    FOREIGN KEY (iso_code) REFERENCES country(iso_code),
    FOREIGN KEY (vaccine) REFERENCES vaccine(vaccine),
    PRIMARY KEY (iso_code, vaccine)   
);

-- create vaccination
CREATE TABLE vaccination (
    iso_code                TEXT    NOT NULL,
    date                    TEXT    NOT NULL,
    total_vaccinations      INTEGER DEFAULT 0,
    people_vaccinated       INTEGER DEFAULT 0,
    people_fully_vaccinated INTEGER DEFAULT 0,
    total_booster           INTEGER DEFAULT 0,
    daily_vaccination_raw   INTEGER DEFAULT 0,
    daily_vaccination       INTEGER DEFAULT 0,
    daily_people_vaccinated NUMERIC DEFAULT 0,
    PRIMARY KEY (iso_code,date),
    FOREIGN KEY (iso_code) REFERENCES country (iso_code) 
);
   
-- Create vaccination_age
CREATE TABLE vaccination_age (
    iso_code                            TEXT    NOT NULL,
    date                                TEXT,
    age_group                           TEXT,
    people_vaccinated_per_hundred       INTEGER DEFAULT 0,
    people_fully_vaccinated_per_hundred INTEGER DEFAULT 0,
    people_with_booster_per_hundred     INTEGER DEFAULT 0,
    PRIMARY KEY (iso_code, date, age_group),
    FOREIGN KEY (date,iso_code) REFERENCES vaccination (date,iso_code),
    FOREIGN KEY (age_group) REFERENCES age_group (age_group)
);

-- Create manufacture_date
CREATE TABLE manufacture_date (
    iso_code          TEXT    NOT NULL,
    date              TEXT    NOT NULL,
    vaccine           TEXT    NOT NULL,
    total_vaccination INTEGER DEFAULT (0),
    PRIMARY KEY (iso_code,date,vaccine),
    FOREIGN KEY (vaccine) REFERENCES vaccine (vaccine),
    FOREIGN KEY (iso_code) REFERENCES country (iso_code) 
);

    
-- create State_Vaccinations
CREATE TABLE state_vaccinations (
    iso_code                TEXT    NOT NULL,
    date                    TEXT    NOT NULL,
    states                  TEXT    NOT NULL,
    total_vaccinations      INTEGER DEFAULT 0,
    total_distributed       INTEGER DEFAULT 0,
    people_vaccinated       INTEGER DEFAULT 0,
    people_fully_vaccinated INTEGER DEFAULT 0,
    daily_vaccination_raw   INTEGER DEFAULT 0,
    daily_vaccinations      INTEGER DEFAULT 0,
    share_doses_used        INTEGER DEFAULT 0,
    total_boosters          INTEGER DEFAULT 0,
    population              INTEGER DEFAULT 0,  
    PRIMARY KEY (iso_code,date,states),
    FOREIGN KEY(iso_code,date) REFERENCES vaccination(iso_code,date)
);

-- create country_population
CREATE TABLE country_population (
    iso_code   TEXT,
    year       INTEGER,
    population INTEGER,
    PRIMARY KEY (iso_code),
    FOREIGN KEY(iso_code) REFERENCES country (iso_code)
);