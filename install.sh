#!/bin/bash

# Check if the project name was provided
if [ -z "$1" ]
then
    echo "Usage: $0 <project_name>"
    exit 1
fi

# Get the project name from the command-line arguments
project_name="$1"

# Define the django_init function
django_init() {
    project="$1"
    django-admin startproject --template=https://github.com/knowsuchagency/django-template/archive/main.zip $project
    cd $project
    just
}

# Call the function with the user's input
django_init $project_name
