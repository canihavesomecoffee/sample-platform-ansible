FROM python:3.9-slim-buster

RUN apt-get update \
    && apt-get -q -y install git gcc python3-libvirt libxslt1-dev libxml2-dev mediainfo

WORKDIR /var/www/sample-platform/
RUN python -m pip install --upgrade pip setuptools wheel \
    && pip install -r requirements.txt

CMD ["python", "bootstrap_gunicorn.py"]