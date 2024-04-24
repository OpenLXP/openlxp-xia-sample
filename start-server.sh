#!/usr/bin/env bash
# start-server.sh
if [ -n "$DJANGO_SUPERUSER_USERNAME" ] && [ -n "$DJANGO_SUPERUSER_PASSWORD" ] ; then
    (cd openlxp-xia-sample; python manage.py createsuperuser --no-input)
fi
(cd openlxp-xia-sample; gunicorn openlxp_xia_sample_project.wsgi --reload --user 1001 --bind 0.0.0.0:8000 --workers 3)
