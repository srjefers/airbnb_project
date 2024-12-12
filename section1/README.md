# Section 1: Data Cleaning, PostgreSQL, and Database Modeling (1.5 Hours)
## Summary
### Task 1: Data Cleaning
Utilize the New York City Airbnb Open Data dataset. Identify and address common
data quality issues such as missing values, duplicates, and inconsistencies.
#### Deliverables:
1. A summary report detailing the data cleaning steps performed.
2. The cleaned dataset saved as a CSV file.

### Task 2: Database Design
Design a relational schema to store the cleaned Airbnb data, focusing on entities such
as Hosts, Listings, Reviews, and Neighborhoods.
#### Deliverables:
1. An Entity-Relationship (ER) Diagram of the schema.
2. SQL DDL statements to create the tables in PostgreSQL.

### Task 3: SQL Querying
Develop SQL queries to:
1. List the top 5 neighborhoods with the highest average listing prices.
2. Identify hosts with more than 5 listings.
3. Calculate the average number of reviews per listing for each neighborhood.

## Solution
### Task 1: Data Cleaning
Data cleaning has been implemented by using pandas. With that we were able to read, clean and export data.
Jupyter nootbook was also used on the first time to be able to have a better view of the data and how it was going to be cleaned before creating the python script.

#### Data Cleaning Steps
1. `missingno` library has been used to be able to take a look at the data, with that library we were able to have an overview about which columns have more missing values. 
2. `df.info()` was used to review the data type of each of the columns to review if there was some columns that are required to be casted.
3. Some columns has been `capitalized` since the records has been comming as uppercase.
4. For some of the columns where we got the null records it was replaces by 0 if the column was numeric or with a Not-defined records if it was an string.

#### How to run it?
Make sure that you already have Python3 installed on your machine.
```bash
python -m venv data_cleaning	
source data_cleaning/bin/activate		# activate the environment for Mac and Linux OR
data_cleaning\Scripts\activate			# activate the environment for Windows
pip install -r requirements.txt
python3 script.py --file_path=./data/AB_NYC_2019.csv --export_path=./data/export.csv
```

### Task 2: Database Design
Diagram has been created following a desing of a Dimensions and a Fact table. Since we are going to split the data to avoid duplicates and redudancy.

RoomType dimension has been created also, since it was a columns that was identified as part of the duplicated records on each of the rows of the fact table.

#### Listings dimension not created?
Please reveiw at the references appened at the end of this file, the listing colums is part of the host, since each host has the same value of the listing and it is being duplicated on each row.

### Task 3: SQL Querying
SQL scripts can be found at the sql/ directory. Those sql scripts has been done by using CTE's since with the sql feature we are able to reuse the sql that we are writting.

## Project layout

    ├─ task1/               Task 1, to cleand the airbnb NYC data from kaggle.
    │  └─ data/             This folder should contains the csv files to clean.    
    ├─ task2/               Task 2, ER Diagram and the database script.
    │  └─ sql/              This folder has the sql script that was created for the database.        
    └─ task3/               Task 3, the sql script with the queries.
       └─ sql/              Sql scripts.        

## References 
> https://www.kaggle.com/datasets/dgomonov/new-york-city-airbnb-open-data/discussion/115213
> https://www.kaggle.com/datasets/dgomonov/new-york-city-airbnb-open-data/discussion/120300
