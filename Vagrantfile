Vagrant.configure("2") do |config|
  config.vm.box = "bento/debian-11"
  config.ssh.insert_key = false

  config.vm.define "flask" do |debian|
    debian.vm.hostname = "debian"
    debian.vm.network "private_network", ip: "192.168.56.20"

    debian.vm.provision "shell", inline: <<-SHELL
      apt-get update && apt-get install -y git python3-pip
      pip3 install pipenv
      mkdir -p /var/www/app
      git clone https://github.com/Azure-Samples/msdocs-python-flask-webapp-quickstart /var/www/msdocs-python-flask-webapp-quickstart
      chown -R vagrant:www-data /var/www/
      chmod -R 775 /var/www/
    SHELL

    debian.vm.provision "shell", privileged: false, inline: <<-SHELL
      export PATH="$PATH:/home/vagrant/.local/bin"
      
      # App 1
      cd /var/www/app
      pipenv install flask gunicorn
      cp /vagrant/application.py /vagrant/wsgi.py .

      # App 2 (Azure)
      cd /var/www/msdocs-python-flask-webapp-quickstart
      pipenv install -r requirements.txt
      pipenv install gunicorn
    SHELL

    # PASO 3: El script de tu profesor (Root)
    # Configura servicios, Nginx y arranca todo
    debian.vm.provision "shell", path: "flask.sh"
  end
end