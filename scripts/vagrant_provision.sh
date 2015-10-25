#!/usr/bin/env bash
# Install essential packages from Apt
apt-get update -y
# Python dev packages
apt-get install -y build-essential python python-dev python-setuptools python-pip \
	libxml2-dev libxslt1-dev nginx uwsgi uwsgi-plugin-python                      \
	postgresql postgresql-contrib libpq-dev


pip install virtualenv virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
echo "WORKON_HOME=$WORKON_HOME"
source /usr/local/bin/virtualenvwrapper.sh

mkvirtualenv oe
workon oe

# this is convenient but not always what is wanted
#echo "Freezing reqs"
#pip freeze > requirements.txt
echo "Installing Requirements"
pip install -r /vagrant/requirements.txt

/vagrant/scripts/postgres_provision.sh

echo ""
print_db_usage

echo "PWD=$PWD"
cd /vagrant
echo "Creating DB models"
cat << EOF | python
from open_event import app
from open_event.models import db

with app.app_context():
	db.create_all()
EOF

# Tag the provision time:
date > "$PROVISIONED_ON"

