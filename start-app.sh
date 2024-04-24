#!/usr/bin/env bash

python manage.py waitdb 
python manage.py migrate 
python manage.py createcachetable 
python manage.py loaddata admin_theme_data.json 
python manage.py loaddata xiaconfiguration.json 
python manage.py loaddata xsrconfiguration.json 
python manage.py loaddata metadatafieldoverwrite.json 
cd /tmp/app/ 
pwd 
./start-server.sh
