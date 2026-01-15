#!/bin/bash
set -xe

# Actualizar repositorios e instalar paquetes
sudo apt-get update
sudo apt-get install -y python3-pip nginx

# Crear directorio de la aplicación
sudo mkdir -p /var/www/app
# Asignar dueño correcto (usuario vagrant)
sudo chown -R vagrant:www-data /var/www/app
sudo chmod -R 775 /var/www/app

# Iniciar Nginx para evitar problemas posteriores
sudo systemctl enable nginx
sudo systemctl start nginx
