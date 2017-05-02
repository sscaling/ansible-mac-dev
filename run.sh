#!/bin/bash

#install virtualenv
# pip install virtualenv --user python


#choose a folder to setup the virtual environment in
cd my_project_folder
virtualenv venv
#activate environment
source venv/bin/activate
#install ansible (sudo not required)
pip install ansible
