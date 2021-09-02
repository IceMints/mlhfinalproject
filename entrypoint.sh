#!/bin/bash
flask db migrate
flask db upgrade

if [ "$FLASK_ENV" = "development"]
then
    echo "Running Flask Development Server"
    flask run --host=0.0.0.0 --port=80
else
    gunicorn --worker-class eventlet -w 1 --bin 0.0.0.0:80 wsgi:app --capture-output --log-level debug
fi


