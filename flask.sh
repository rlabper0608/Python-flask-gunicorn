#!/bin/bash

# Evitar bloqueos e interactividad
export DEBIAN_FRONTEND=noninteractive
set -xeu

apt-get update

apt-get -y install nginx python3-pip python3-dev git

mkdir -p /var/www/app
chown -R vagrant:www-data /var/www/app
chmod -R 775 /var/www/app

rm -rf /var/www/msdocs-python-flask-webapp-quickstart
cd /var/www
git clone https://github.com/Azure-Samples/msdocs-python-flask-webapp-quickstart

chmod 755 /var/www/msdocs-python-flask-webapp-quickstart
chown -R vagrant:www-data /var/www/msdocs-python-flask-webapp-quickstart

systemctl start nginx
systemctl status nginx

cp /vagrant/flask_app.service /etc/systemd/system/flask_app.service
cp /vagrant/azure_app.service /etc/systemd/system/azure_app.service

cp /vagrant/app.conf /etc/nginx/sites-available/app.conf

systemctl daemon-reload
systemctl restart flask_app azure_app
systemctl enable flask_app azure_app
systemctl start flask_app azure_app

ln -sf /etc/nginx/sites-available/app.conf /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default  
nginx -t                             
systemctl restart nginx