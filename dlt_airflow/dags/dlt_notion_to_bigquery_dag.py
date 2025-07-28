from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime, timedelta
from pendulum import timezone
import sys
import os

# Add pipeline path to PYTHONPATH
pipeline_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'dlt_pipelines'))
if pipeline_path not in sys.path:
    sys.path.append(pipeline_path)

# Import your DLT loader
from notion_pipeline import load_databases

default_args = {
    'owner': 'airflow',
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

with DAG(
    dag_id='dlt_notion_to_bigquery',
    description='Ingest Notion data into BigQuery using DLT',
    default_args=default_args,
    start_date=datetime(2025, 7, 17, tzinfo=timezone("America/Vancouver")),
    # schedule='@daily',  # ✔️ valid in Airflow 3.0
    schedule = '0 22 * * *',  # Runs at 10:00 PM every day
    catchup=False,
    tags=['dlt', 'notion', 'bigquery'],
) as dag:

    run_dlt_pipeline = PythonOperator(
        task_id='run_dlt_pipeline',
        python_callable=load_databases,
    )

    run_dlt_pipeline
