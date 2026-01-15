Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"
  config.vm.hostname = "debian"
  config.vm.network "private_network", ip: "192.168.56.10"

  config.vm.synced_folder ".", "/vagrant"

  config.vm.provider "virtualbox" do |vb|
  vb.memory = "2048"
  vb.cpus = 2
  # Esto evita bloqueos en procesos de red/seguridad
  vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
  vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  config.vm.provision "shell", path: "bootstrap.sh"
end