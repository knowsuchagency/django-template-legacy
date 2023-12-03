# Django Project Template

## Features
* included `core` app with `urls.py` added to project
* preconfigured [django-tailwind](https://django-tailwind.readthedocs.io/en/latest/index.html) `theme` app
* [whitenoise](https://whitenoise.evans.io/en/latest/) configured for hosting static files
* dockerized deployment to [fly.io](https://fly.io/)
* included `justfile`
* additional default packages
    * [django-widget-tweaks](https://pypi.org/project/django-widget-tweaks/)
    * [django-debug-toolbar](https://pypi.org/project/django-debug-toolbar/)
    * [django-browser-reload](https://pypi.org/project/django-browser-reload/)
* reactivity
  * [htmx](https://htmx.org/) and [alpine](https://alpinejs.dev/) included in the base theme template
  * adds [django-htmx](https://django-htmx.readthedocs.io/en/latest/middleware.html#django_htmx.middleware.HtmxMiddleware) app

## Requirements

* npm
* [just](https://github.com/casey/just)
* [concurrently](https://www.npmjs.com/package/concurrently)

## Usage

```bash
# make sure you have django-admin installed globally in a 3.11 interpreter
curl https://raw.githubusercontent.com/knowsuchagency/django-template/main/install.sh | bash -s <project_name>
```
