# First-time build can take upto 10 mins.
FROM apache/airflow:slim-3.0.3-python3.11

ENV AIRFLOW_HOME=/opt/airflow

USER root
# Install system deps needed by some packages
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    libpq-dev \
    libffi-dev \
    libssl-dev \
    curl \
    unzip \
    vim \
    gnupg \
    --no-install-recommends && apt-get clean



# Ref: https://airflow.apache.org/docs/docker-stack/recipes.html

SHELL ["/bin/bash", "-o", "pipefail", "-e", "-u", "-x", "-c"]

ARG CLOUD_SDK_VERSION=423.0.0
ENV GCLOUD_HOME=/opt/google-cloud-sdk
ENV PATH="${GCLOUD_HOME}/bin/:${PATH}"

RUN mkdir -p "${GCLOUD_HOME}" \
    && DOWNLOAD_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz" \
    && TMP_DIR="$(mktemp -d)" \
    && curl -fL "${DOWNLOAD_URL}" --output "${TMP_DIR}/google-cloud-sdk.tar.gz" \
    && tar xzf "${TMP_DIR}/google-cloud-sdk.tar.gz" -C "${GCLOUD_HOME}" --strip-components=1 \
    && "${GCLOUD_HOME}/install.sh" --bash-completion=false --path-update=false --usage-reporting=false --quiet \
    && rm -rf "${TMP_DIR}" \
    && gcloud --version

# Switch to airflow user before installing Python packages
USER $AIRFLOW_UID

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR $AIRFLOW_HOME

COPY dlt_pipelines dlt_pipelines