FROM python:3.10-slim

RUN apt update
RUN apt install -y npm

WORKDIR /app

COPY requirements.txt ./

RUN pip install -U pip \
    pip install -r requirements.txt

RUN python manage.py tailwind install

COPY {{ project_name }}/ ./{{ project_name }}/
COPY core/ ./core/
COPY theme/ ./theme/

COPY manage.py ./

RUN python manage.py tailwind build

ENV DEBUG=false

CMD gunicorn {{ project_name }}.wsgi -b 0.0.0.0:8080
