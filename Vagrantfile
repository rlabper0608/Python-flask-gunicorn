# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/debian-11"
  config.ssh.insert_key= false


  config.vm.define "flask" do |debian|
     debian.vm.hostname="debian"
     debian.vm.network "private_network",ip: "192.168.56.10"
     debian.vm.provision "shell",path: "bootstrap.sh"
     debian.vm.provision "shell",privileged: false,inline: <<-SHELL

     pip3 install pipenv python-dotenv
     export PATH="$PATH:/home/vagrant/.local/bin"
     pipenv --version

     cd /var/www/app

     echo "FLASK_APP=wsgi.py" > .env
     echo "FLASK_ENV=production" >> .env

     pipenv install flask gunicorn

     cp /vagrant/application.py ./
     cp /vagrant/wsgi.py ./

     # COMANDO PARQA QUE CORRA DIRECTAMENTE pipenv run flask run --host '0.0.0.0' &
     pipenv run gunicorn --workers 4 --bind 0.0.0.0:5000 wsgi:app --daemon
     SHELL
  end
end