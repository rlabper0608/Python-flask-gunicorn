Vagrant.configure("2") do |config|
  # Box correcta según la práctica
  config.vm.box = "debian/bullseye64"
  config.vm.hostname = "bullseye"
  config.vm.network "private_network", ip: "192.168.56.10"

  # Carpeta sincronizada
  config.vm.synced_folder ".", "/vagrant"

  # Recursos de la VM
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
    vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  # Provisioner 1: root (sudo) -> instalar paquetes y crear directorio
  config.vm.provision "shell", path: "bootstrap.sh", privileged: true

  # Provisioner 2: usuario vagrant -> entorno virtual, pipenv, app
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    # Asegurar que pipenv se instala para el usuario
    pip3 install --user pipenv python-dotenv

    # Añadir ~/.local/bin al PATH temporalmente para el provision
    export PATH="$HOME/.local/bin:$PATH"

    # Entrar en el directorio del proyecto
    cd /var/www/app

    # Crear archivo .env con las variables de entorno
    cat > .env <<EOF
FLASK_APP=wsgi.py
FLASK_ENV=production
EOF

    # Crear entorno virtual y dependencias
    pipenv install flask gunicorn

    # Crear archivos de la app Flask
    cat > application.py <<EOF
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return '<h1>App desplegada</h1>'
EOF

    cat > wsgi.py <<EOF
from application import app

if __name__ == '__main__':
    app.run(debug=False)
EOF
  SHELL
end
