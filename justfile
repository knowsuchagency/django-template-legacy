# initialize development
init:
    just install
    just template
    .venv/bin/python manage.py makemigrations
    .venv/bin/python manage.py migrate
    just --list

# create virtual environment
create-venv:
    test -d .venv || python3.11 -m venv .venv

# install packages
install: create-venv
    .venv/bin/pip install -U pip
    .venv/bin/pip install -r requirements.txt
    .venv/bin/pip install -r requirements-dev.txt
    .venv/bin/python manage.py tailwind install

# run server with tailwind
runserver:
    .venv/bin/python manage.py tailwind install
    concurrently -n tailwind,django ".venv/bin/python manage.py tailwind start" "sleep 3 && .venv/bin/python manage.py runserver"

# build and run in docker as if it were production
up:
    docker-compose up --build

# templatize non-django files
template:
    #!.venv/bin/python
    from pathlib import Path
    from django.template import Engine, Context
    
    FILES = ["Dockerfile", "docker-compose.yml", "fly.toml"]

    project_name_underscore = Path.cwd().stem
    project_name = project_name_underscore.replace("_", "-")

    for f in FILES:
        path = Path(f)
        template = Engine().from_string(path.read_text())
        rendered = template.render(
            Context({
            "project_name": project_name, 
            "project_name_underscore": project_name_underscore"})
            )
        path.write_text(rendered)
        print(f"templated {f}")

# set up serverless AWS deployment
init-zappa:
    .venv/bin/zappa init

# set up fly.io deployment
init-fly:
    flyctl launch

# deploy to zappa
deploy-zappa:
    .venv/bin/zappa deploy || .venv/bin/zappa update

# deploy to fly.io
deploy-fly:
    flyctl deploy
