## setup.py file
The setup.py file is an essential prt of packaging and 
distributing python projects.It is used by setuptools
to define the configuration of your project,such as its metadata,dependencies and more

## push_data.py file
This script:
1) Loads MongoDB connection string from .env.
2) Reads a CSV file into Pandas.
3) Converts the CSV into JSON-like records.
4) Inserts those records into a MongoDB collection.
5) Prints inserted records + count.
   
## Config_entity.py file
TrainingPipelineConfig → Sets up global pipeline paths (artifact dir, model dir, timestamp).
DataIngestionConfig → Creates paths for feature store, train/test datasets, and MongoDB details.

## data_ingestion.py file
DataIngestion automates the process of:
1) Pulling raw data from MongoDB.
2) Saving a clean CSV in feature store.
3) Splitting into train.csv and test.csv.
4) Returning file paths in a DataIngestionArtifact.
This is the first step of any ML pipeline (getting and organizing raw data).

### Network Security Projects For Phising Data

Setup github secrets:
AWS_ACCESS_KEY_ID=

AWS_SECRET_ACCESS_KEY=

AWS_REGION = us-east-1

AWS_ECR_LOGIN_URI = 788614365622.dkr.ecr.us-east-1.amazonaws.com/networkssecurity
ECR_REPOSITORY_NAME = networkssecurity


Docker Setup In EC2 commands to be Executed
#optinal

sudo apt-get update -y

sudo apt-get upgrade

#required

curl -fsSL https://get.docker.com -o get-docker.sh

sudo sh get-docker.sh

sudo usermod -aG docker ubuntu

newgrp docker
