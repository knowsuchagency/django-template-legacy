#!/bin/bash

# Prompt the user for the project name
echo "Please enter your project name: "
read project_name

# Define the django_init function
django_init() {
    project="$1"
    django-admin startproject --template=https://github.com/knowsuchagency/django-template/archive/main.zip $project
    cd $project
    just
}

# Call the function with the user's input
django_init $project_name
