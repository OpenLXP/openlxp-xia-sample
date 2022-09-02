#Dockerfile

FROM nginx
COPY courseList.json /opt/app/courseList.json
RUN chmod 777 /opt/app/courseList.json
COPY nginx.default /etc/nginx/conf.d/default.conf

EXPOSE 80