#!/bin/bash

# Evitar bloqueos e interactividad
export DEBIAN_FRONTEND=noninteractive
set -xeu

apt-get update

apt-get -y install nginx python3-pip python3-dev

mkdir -p /var/www/app
chown -R vagrant:www-data /var/www/app
chmod -R 775 /var/www/app

sudo systemctl start nginx
sudo systemctl status nginx

cp /vagrant/flask_app.service /etc/systemd/system/flask_app.service

sudo systemctl daemon-reload
systemctl enable flask_app
systemctl start flask_app


cp /vagrant/app.conf /etc/nginx/sites-available/app.conf

sudo ln -s /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default  
sudo nginx -t                             
sudo systemctl restart nginx