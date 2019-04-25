Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.hostname = 'php-dev-box'

  # Enable plugin to use .env files
  config.env.enable

  # Set to a sensible size for a decent # of M1/M2/Generic PHP projects:
  config.disksize.size = ENV['DISK_SIZE']

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: ENV['PRIVATE_NETWORK_IP']

  config.vm.synced_folder ENV['SYNCED_FOLDER_HOST'], "/var/www/html", :nfs => true, mount_options: ['rw', 'vers=3', 'tcp', 'fsc' ,'actimeo=2']

  # Forward the SSH agent: 
  config.ssh.forward_agent = true

  config.vm.network :forwarded_port, guest: 80, host: 80 # apache
  # config.vm.network :forwarded_port, guest: 3306, host: 3306 # mysql
  # config.vm.network :forwarded_port, guest: 9001, host: 9001 # xdebug

  # Provisioning
  config.vm.provision "file", source: "./config/dynamic-vhosts_vhost_alias.conf", destination: "/tmp/dynamic-vhosts_vhost_alias.conf"
  config.vm.provision "file", source: "./config/n98-magerun2.yaml", destination: "/tmp/n98-magerun2.yaml"
  config.vm.provision "file", source: "./scripts/.", destination: "/tmp"
  config.vm.provision :shell, path: './provisioning/bootstrap.sh', keep_color: true
  config.vm.provision :shell, path: './provisioning/setup_php_versions.sh', keep_color: true
  config.vm.provision :shell, path: './provisioning/tools.sh', keep_color: true

  config.vm.provider 'virtualbox' do |v|
    v.memory = ENV['MEMORY']
    v.cpus   = ENV['CPUS']
  end

end