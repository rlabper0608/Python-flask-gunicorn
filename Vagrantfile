Vagrant.configure("2") do |config|
  config.vm.box = "bento/debian-11"
  config.ssh.insert_key = false

  config.vm.define "flask" do |debian|
    debian.vm.hostname = "debian"
    debian.vm.network "private_network", ip: "192.168.56.20"
    
    # Primero el script de root
    debian.vm.provision "shell", path: "flask.sh"

    # Segundo: Bloque de usuario para la App
    debian.vm.provision "shell", privileged: false, inline: <<-SHELL
      # Instalamos pipenv para el usuario vagrant
      pip3 install --user pipenv python-dotenv
      export PATH="$PATH:/home/vagrant/.local/bin"
      
      cd /var/www/app

      echo "FLASK_APP=wsgi.py" > .env
      echo "FLASK_ENV=production" >> .env

      # Instalación de dependencias
      /home/vagrant/.local/bin/pipenv install flask gunicorn

      # Copiamos los archivos (asegúrate de que existen en tu carpeta)
      cp /vagrant/application.py .
      cp /vagrant/wsgi.py .

      # Prueba rápida de Gunicorn
      /home/vagrant/.local/bin/pipenv run gunicorn --workers 4 --bind 0.0.0.0:5000 wsgi:app --daemon
    SHELL
  end
end