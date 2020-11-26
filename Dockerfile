FROM python:3.6-alpine3.9

MAINTAINER Daniel Nemeth <daniel.nemeth83@yahoo.com>

RUN apk add --no-cache \
      gcc \
      libffi-dev \
      openssl-dev \
      linux-headers \
      musl-dev \
      make \
      nginx \
      supervisor

WORKDIR /app
COPY requirements.txt ./requirements.txt
COPY process_launcher ./process_launcher/
COPY ScriptRunner ./ScriptRunner
COPY static ./static
COPY manage.py ./manage.py

RUN pip install -r requirements.txt
RUN python manage.py migrate

COPY nginx.conf /etc/nginx
COPY uwsgi.ini /etc/uwsgi/
COPY uwsgi_params ./uwsgi_params
COPY supervisord.conf /etc/supervisord.conf


RUN mkdir -p /run/nginx \
      && ln -sf /dev/stdout /var/log/nginx/access.log \
      && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 3080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
