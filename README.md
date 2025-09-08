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

## Artifact_entity.py file
This file is all about artifacts — in ML pipelines, an artifact means the output of a process that will be passed to the next stage.

Each class here is like a container for pipeline outputs:

1) DataIngestionArtifact → paths to train/test data.
2) DataValidationArtifact → status + clean/invalid data paths + drift report.
3) DataTransformationArtifact → transformed data + transformer object.
4) ClassificationMetricArtifact → model evaluation metrics.
5) ModelTrainerArtifact → final model file + metrics for train & test.

## __init__.py file

This file is basically a constants/configuration module. Instead of hardcoding 
values everywhere in the pipeline, all the important paths, filenames, and hyperparameters are stored here once and reused.

This file is the central config hub.
1) Keeps everything (paths, file names, thresholds, database names) in one place.
2) Makes the pipeline flexible → if you change dataset name, model name, or thresholds, you only update here.


## data_ingestion.py file
DataIngestion automates the process of:
1) Pulling raw data from MongoDB.
2) Saving a clean CSV in feature store.
3) Splitting into train.csv and test.csv.
4) Returning file paths in a DataIngestionArtifact.
This is the first step of any ML pipeline (getting and organizing raw data).

## data_transformation.py file
This class is handling the feature preprocessing stage of
your ML pipeline (cleaning, imputing missing values, preparing data for model training).

This class:
1) Reads validated train/test data.
2) Creates a preprocessing pipeline (KNNImputer).
3) Fits it on training features.
4) Applies transformation on both train & test.
5) Saves transformed arrays + preprocessor object.
6) Returns a DataTransformationArtifact so the next stage (Model Training) can use it.

## data_validation.py file

This piece of code is handling the data validation 
stage of your ML pipeline — making sure the input data is valid before training.

This class:
1) Loads schema (expected structure).
2) Reads train & test datasets.
3) Checks if number of columns match schema.
4) Detects data drift between train/test.
5) Saves validated train/test files.
6) Produces a DataValidationArtifact for the next pipeline stage.
   
## data_schema.yaml file 
This section defines all features + target column (Result) along with their data types.

This way:
1) columns = schema for data validation
2) numerical_columns = model features
3) target_column = label for training
## model_trainer.py file
This class is the heart of your ML pipeline → it picks candidate models, 
tunes them, evaluates them, tracks experiments with MLflow, and finally saves the best model.

ModelTrainer pipeline does the following:
1) Loads transformed data.
2) Trains multiple models with hyperparameters.
3) Picks best model based on evaluation.
4) Evaluates with precision, recall, F1.
5) Logs metrics & model to MLflow/Dagshub.
6) Saves final model (NetworkModel) and plain sklearn model.
7) Returns ModelTrainerArtifact.

## estimator.py file
This is the wrapper that bundles your 
preprocessor (feature transformation pipeline) and the trained ML model together.

So in short:
NetworkModel = bundle of preprocessor + trained model with a clean .predict() API.

## utils.py file
It provides reusable functions like reading/writing files, 
saving/loading models, and evaluating ML algorithms.

This utils file gives you:
1) File ops → read/write YAML.
2) Data ops → save/load arrays.
3) Model ops → save/load objects.
4) Evaluation → run hyperparameter tuning + pick best model.
   
 ## classification_metric.py file
This function is exactly what we needed to replace r2_score for classification tasks.

This function is much better for your phishing detection project (binary classification).

⚠️ But right now, your evaluate_models in utils is still using r2_score.
👉 We should update it to use get_classification_score instead, so that the best model selection is based on F1/precision/recall rather than regression metrics.

## training_pipeline.py file
In short: This class is the conductor of your ML orchestra 🎶 – it ensures all 
steps (ingestion → validation → transformation → training → deployment) are executed in the correct order and safely stored in the cloud.

## app.py file
This is FastAPI app 🚀. This script is basically the deployment layer of your ML project.

This file:
1) Connects to MongoDB (for data source).
2) Starts a FastAPI server.
3) Provides two main routes:
  /train → triggers ML pipeline training.
  /predict → accepts a CSV, preprocesses it, predicts with trained model, and shows results in an HTML table.

## main.py file
This script is essentially your pipeline runner in a more manual (step-by-step) 
way compared to the automated TrainingPipeline class you showed earlier.

This script runs the entire pipeline manually in sequence:
1) Data Ingestion
2) Data Validation
3) Data Transformation
4) Model Training
Each stage produces an artifact and passes it to the next stage.

## main.yml file
This is GitHub Actions CI/CD workflow that:
1) CI (Continuous Integration)
Runs on every push to main (ignoring README.md).
Lints and runs unit tests.
2) CD (Continuous Delivery)
Builds & pushes a Docker image to Amazon ECR.
3) CD (Continuous Deployment)
Runs on a self-hosted runner (your server/EC2).
Pulls the latest ECR image.
Runs the container.
Cleans up old images/containers.

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
