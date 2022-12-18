FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt ./

RUN pip install -U pip \
    pip install -r requirements.txt

COPY {{ project_name }}/ ./{{ project_name }}/

COPY manage.py ./

CMD uvicorn {{ project_name }}.asgi:application --host 0.0.0.0 --port 8080
