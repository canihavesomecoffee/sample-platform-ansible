FROM python:3.9-slim-buster

RUN apt-get update \
    && apt-get -q -y install git gcc nginx python3-libvirt libxslt1-dev libxml2-dev qemu-kvm libvirt-dev virt-manager mediainfo

WORKDIR /var/www
RUN git clone https://github.com/CCExtractor/sample-platform.git

WORKDIR /var/www/sample-platform/
RUN python -m pip install --upgrade pip setuptools wheel \
    && pip install -r requirements.txt

RUN cp "install/platform" /etc/init.d/platform \
    && sed -i "s#BASE_DIR#`pwd`#g" /etc/init.d/platform \
    && chmod 755 /etc/init.d/platform \
    && update-rc.d platform defaults

CMD ["service", "platform", "start"]