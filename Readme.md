# Ansible Mac Dev

basic setup for Mac dev machine

## Requirements

* xcode tools

	xcode-select --install

* Ansible 2.0

	easy_install pip
	pip install ansible==2.3.0.0 --user python

## Deploy

	ansible-playbook -i localhost dev-setup.yml


# TODO

* DNSMasq
