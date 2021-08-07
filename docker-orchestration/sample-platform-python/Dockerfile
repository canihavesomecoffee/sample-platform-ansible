FROM python:3.9-slim-buster

ARG config_application_root
ARG db_user
ARG db_user_password
ARG db_name
ARG config_server_name
ARG config_application_root
ARG github_token
ARG github_owner_name
ARG github_repository
ARG email_domain
ARG email_api_key
ARG github_deploy_key
ARG github_ci_key
ARG kvm_linux_name
ARG kvm_windows_name
ARG kvm_max_runtime
ARG server_name
ARG ftp_port
ARG max_content_length
ARG min_pwd_len
ARG max_pwd_len
ARG sample_repository


WORKDIR /var/www

RUN apt-get update && apt-get install -y git
RUN git clone https://github.com/CCExtractor/sample-platform.git

WORKDIR /var/www/sample-platform/install
COPY ./install.sh ./
RUN chmod +x install.sh && ./install.sh

CMD ["service", "platform", "start"]