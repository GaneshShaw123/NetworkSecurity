FROM python:3.10-slim-bullseye  

WORKDIR /app
COPY . /app

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        curl unzip ca-certificates && \
    pip install --upgrade pip && \
    pip install awscli && \
    rm -rf /var/lib/apt/lists/*

RUN pip install -r requirements.txt

CMD ["python3", "app.py"]
