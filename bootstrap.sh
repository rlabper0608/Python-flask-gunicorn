#!/bin/bash
set -xeu
sudo apt-get update
sudo apt-get install -y python3-pip nginx

sudo mkdir -p /var/www/app
sudo chown -R $USER:www-data /var/www/app
sudo chmod -R 775 /var/www/app

cd /var/www/app
pipenv install flask gunicorn

# Comprobación de versiones
pipenv --version
gunicorn --version