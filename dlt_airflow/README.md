## INTRO
This is a scheduled workflow in ***Airflow*** running at 22:00 PST every day when the docker containers are up. 

**Task**: It loads records from a ***Notion*** database into a Google ***BigQuery*** dataset table.
If the target table does not exist, ***dlt*** will create the table directly.

**Tools**: Airflow, 
[dlt](https://dlthub.com/), BigQuery, [Notion API](https://developers.notion.com/)


## TIPS

### Settings in docker-compose.yaml

Update the paths and names of the following items:

- GOOGLE_APPLICATION_CREDENTIALS: XXXXXX
- AIRFLOW_CONN_GOOGLE_CLOUD_DEFAULT: 'google-cloud-platform://?extra__google_cloud_platform__key_path=XXXXXX'
- GCP_PROJECT_ID: 'XXXXXX'
- GCP_GCS_BUCKET: 'XXXXXX'

Current data ingestion doesn't use *GCP_GCS_BUCKET* actually - Can ignore or delete this item for the same task.

Also for the **volumes** in line 70-77, map them to your local folders so that DAGs can be read and the changes can be saved.



### Log in Airflow UI
When the docker images are started, use the user name and password generated in the file `simple_auth_manager_passwords.json.generated`.

Ususlly the user name is `admin`.



### Initialize database
The error message:

```
ERROR: You need to initialize the database. Please run `airflow db migrate`. Make sure the command is run using Airflow version 3.0.3.
```
means that the Airflow metadata database hasn't been initialized, which is required before running services like the scheduler, webserver, API server, and DAG processor.

#### 🐳 If You're Using Docker Compose
You can run the command like this:

```bash
docker compose run --rm airflow-cli airflow db migrate
```
Replace airflow-cli with whatever service name you're using in docker-compose.yml to run CLI commands. Sometimes it's just **airflow**.

Then, to start up everything:

```bash
docker compose up
```

#### 📝 Optional: If You Want a Clean Start
If you want to reset everything (i.e., start from a clean slate), run:

```bash
docker compose down --volumes
docker compose up airflow-init  # if you have this step defined
```
Or run this manually after bringing the containers up:

```bash
docker compose run --rm airflow-cli airflow db reset
docker compose run --rm airflow-cli airflow db migrate
```