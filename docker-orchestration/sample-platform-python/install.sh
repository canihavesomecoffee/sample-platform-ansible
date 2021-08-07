#!/bin/bash
#
# Installer for the CCExtractor sample platform Docker
#
# More information can be found on:
# https://github.com/CCExtractor/sample-platform
#
dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
root_dir=$(cd "${dir}"/../ && pwd)
clear
date=$(date +%Y-%m-%d-%H-%M)

echo "Welcome to the CCExtractor platform installer for docker!"
echo ""
echo "-------------------------------"
echo "|   Installing dependencies   |"
echo "-------------------------------"
echo ""
echo "* Updating package list"
apt-get update
echo "* Installing nginx, python, pip, kvm, libvirt and virt-manager"
apt-get -q -y install nginx python python-dev python3-libvirt libxslt1-dev libxml2-dev python-pip qemu-kvm libvirt-dev virt-manager mediainfo
echo "* Update pip, setuptools and wheel"
python -m pip install --upgrade pip setuptools wheel
echo "* Installing pip dependencies"
pip install -r "${root_dir}/requirements.txt"

echo "Setting up the directories.."
mkdir -p "${sample_repository}"
mkdir -p "${sample_repository}/ci-tests"
mkdir -p "${sample_repository}/unsafe-ccextractor"
mkdir -p "${sample_repository}/TempFiles"
mkdir -p "${sample_repository}/LogFiles"
mkdir -p "${sample_repository}/TestResults"
mkdir -p "${sample_repository}/TestFiles"
mkdir -p "${sample_repository}/TestFiles/media"
mkdir -p "${sample_repository}/QueuedFiles"

config_db_uri="mysql+pymysql://${db_user}:${db_user_password}@localhost:3306/${db_name}"

echo "-------------------------------"
echo "|      Finalizing install     |"
echo "-------------------------------"

echo "* Generating config file"
echo "# Auto-generated configuration by install.sh
APPLICATION_ROOT = ${config_application_root}
CSRF_ENABLED = True
DATABASE_URI = '${config_db_uri}?charset=utf8'
GITHUB_TOKEN = '${github_token}'
GITHUB_OWNER = '${github_owner_name}'
GITHUB_REPOSITORY = '${github_repository}'
SERVER_NAME = '${server_name}'
EMAIL_DOMAIN = '${email_domain}'
EMAIL_API_KEY = '${email_api_key}'
GITHUB_DEPLOY_KEY = '${github_deploy_key}'
GITHUB_CI_KEY = '${github_ci_key}'
INSTALL_FOLDER = '${root_dir}'
KVM_LINUX_NAME = '${kvm_linux_name}'
KVM_WINDOWS_NAME = '${kvm_windows_name}'
KVM_MAX_RUNTIME = $kvm_max_runtime # In minutes
SAMPLE_REPOSITORY = '${sample_repository}'
SESSION_COOKIE_PATH = '/'
FTP_PORT = $ftp_port
MAX_CONTENT_LENGTH = $max_content_length
MIN_PWD_LEN = $min_pwd_len
MAX_PWD_LEN = $max_pwd_len
" >"${dir}/../config.py"

# Ensure the files are executable by www-data
chown -R www-data:www-data "${root_dir}" "${sample_repository}"
echo "* Creating startup script"

cp "${dir}/platform" /etc/init.d/platform
sed -i "s#BASE_DIR#${root_dir}#g" /etc/init.d/platform
chmod 755 /etc/init.d/platform
update-rc.d platform defaults
echo "Platform installed!"
