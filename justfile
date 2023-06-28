# initialize development
init:
    just install
    just template
    python manage.py makemigrations
    python manage.py migrate
    just runserver

# install packages
install:
    #!/usr/bin/env bash
    test -d .venv || python3 -m venv .venv
    . .venv/bin/activate
    pip install -U pip
    pip install -r requirements.txt
    pip install -r requirements-dev.txt
    python manage.py tailwind install

# run server with tailwind
runserver:
    which python
    python manage.py tailwind install
    concurrently -n tailwind,django "python manage.py tailwind start" "sleep 3 && python manage.py runserver"

# templatize non-django files
template:
    #!/usr/bin/env python
    from pathlib import Path
    from django.template import Engine, Context
    
    FILES = ["Dockerfile", "docker-compose.yml", "fly.toml"]

    project_name = Path.cwd().stem

    for f in FILES:
        path = Path(f)
        template = Engine().from_string(path.read_text())
        rendered = template.render(Context({"project_name": project_name}))
        path.write_text(rendered)
        print(f"templated {f}")

# set up serverless AWS deployment
init-zappa:
    zappa init

# set up fly.io deployment
init-fly:
    flyctl launch

# deploy to zappa
deploy-zappa:
    zappa deploy || zappa update

# deploy to fly.io
deploy-fly:
    flyctl deploy
