FROM python:3.6-alpine3.9

MAINTAINER Daniel Nemeth <daniel.nemeth83@yahoo.com>

RUN apk add --no-cache \
      gcc \
      libffi-dev \
      openssl-dev \
      linux-headers \
      musl-dev \
      make \
      supervisor

WORKDIR .
COPY requirements.txt /app/requirements.txt
COPY process_launcher /app/process_launcher/
COPY ScriptRunner /app/ScriptRunner
COPY static /app/static
COPY manage.py /app/manage.py

RUN pip install -r /app/requirements.txt
RUN python /app/manage.py migrate

EXPOSE 3080

WORKDIR /app
#CMD ["gunicorn"  , "--bind", "0.0.0.0:8000", "app:app"]
#CMD ["/usr/bin/supervisord", "-n"]
#CMD exec gunicorn ScriptRunner.wsgi:application  --bind 0.0.0.0:3080 --workers 3 --access-logfile /app/access.log --error-logfile /app/error.log
CMD ["gunicorn", "ScriptRunner.wsgi:application", "--bind", "0.0.0.0:3080", "--workers", "3", "--access-logfile", "/app/access.log", "--error-logfile", "/app/error.log"]

