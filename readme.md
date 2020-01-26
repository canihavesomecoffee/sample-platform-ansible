# Sample Platform installation using Ansible

## Prerequisites

TODO

## Installation

```bash
ansible-playbook prepare_host.yaml
ansible-playbook -i inventory.yaml configure_platform.yaml
ansible-playbook -i inventory.yaml deploy_platform.yaml --ask-pass
# Install the base VM's for both Linux & Windows
```
