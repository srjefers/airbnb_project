FROM --platform=linux/amd64 ghcr.io/dbt-labs/dbt-postgres:1.9.latest@sha256:a705312b55af0ebdd149977914c28502a382d74dca8fe51fff368371a61cc8a7

# System setup
RUN apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get install -y --no-install-recommends \
    git \
    ssh-client \
    software-properties-common \
    make \
    build-essential \
    ca-certificates \
    libpq-dev \
  && apt-get clean \
  && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

RUN python -m pip install --upgrade pip setuptools wheel --no-cache-dir

# Create directory for dbt config
RUN mkdir -p /root/.dbt

# Copy dbt profile
COPY profiles.yml /root/.dbt/profiles.yml

# Copy source code
COPY . /usr/app/dbt/
WORKDIR /usr/app/dbt/

ENTRYPOINT ["python","execute_dbt.py"]