# Set up feedack system
from learntools.core import binder
binder.bind(globals())
from learntools.sql.ex1 import *
print("Setup Complete")

# To use BigQuery, we'll import the Python package below:
from google.cloud import bigquery

# The first step in the workflow is to create a Client object. As you'll soon see,
# this Client object will play a central role in retrieving information from BigQuery datasets.

# Create a "Client" object
client = bigquery.Client()

# Construct a reference to the "hacker_news" dataset
dataset_ref = client.dataset("hacker_news", project="bigquery-public-data")

# API request - fetch the dataset
dataset = client.get_dataset(dataset_ref)

# List all the tables in the "hacker_news" dataset
tables = list(client.list_tables(dataset))

# print names of all tables in the dataset (there are four!)
for table in tables:
	print(table.table_id)
	
# Construct a reference to the "full" table
table_ref = dataset_ref.table("full")

# API request - fetch the table
table = client.get_table(table_ref)

# The structure of a table is called its schema. We need to understand
# a table's schema to effectively pull out the data we want. In this example,
# we'll investigate the full table that we fetched above.
	
	
# Print information on all the columns in the "full" table in the "hacker_news" dataset

table.schema

# Preview the first five lines of "full" table
client.list_rows(table, max_results=5).to_dataframe()

# Preview the first five entries in the "by" column of the "full" table

client.list_rows(table, selected_fields=table.schema[:1], max_results=5).to_dataframe()

