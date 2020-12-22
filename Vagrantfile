#Check for required plugins

unless Vagrant.has_plugin?("vagrant-env")
  puts 'Installing vagrant-env Plugin...'
  system('vagrant plugin install vagrant-env')
end

# unless Vagrant.has_plugin?("vagrant-disksize")
#   puts 'Installing vagrant-disksize Plugin...'
#   system('vagrant plugin install vagrant-disksize')
# end
 
unless Vagrant.has_plugin?("vagrant-vbguest")
  puts 'Installing vagrant-vbguest Plugin...'
  system('vagrant plugin install vagrant-vbguest')
end
 
# unless Vagrant.has_plugin?("vagrant-bindfs")
#   puts 'Installing vagrant-bindfs Plugin...'
#   system('vagrant plugin install vagrant-bindfs')
# end

# unless Vagrant.has_plugin?("vagrant-reload")
#   puts 'Installing vagrant-reload Plugin...'
#   system('vagrant plugin install vagrant-reload')
# end

Vagrant.configure("2") do |config|
  # Enable plugin to use .env files
  config.env.enable

  config.vm.box = "ubuntu/bionic64"
  # config.vm.box = "bento/ubuntu-20.04"
  config.vm.hostname = 'php-dev-box'

  #config.vm.box_check_update = false

  # Set to a sensible size for a decent # of M1/M2/Generic PHP projects:
  # config.disksize.size = ENV['DISK_SIZE']
  config.vm.disk :disk, disk_ext: "vdi", size: ENV['DISK_SIZE'], primary: true

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: ENV['PRIVATE_NETWORK_IP']

  config.vm.synced_folder ENV['SYNCED_FOLDER_HOST'], "/var/www/html", type: "nfs"
  # config.vm.synced_folder ENV['SYNCED_FOLDER_HOST'], "/var/www/html", :nfs => true, mount_options: ['rw', 'vers=3', 'tcp', 'fsc' ,'actimeo=2']

  # Forward the SSH agent: 
  config.ssh.forward_agent = true

  config.vm.network :forwarded_port, guest: 80, host: 80 # apache
  # config.vm.network :forwarded_port, guest: 3306, host: 3306 # mysql
  # config.vm.network :forwarded_port, guest: 9001, host: 9001 # xdebug

  # Provisioning
  config.vm.provision "file", source: "./config/dynamic-vhosts_vhost_alias.conf", destination: "/tmp/dynamic-vhosts_vhost_alias.conf"
  config.vm.provision "file", source: "./config/n98-magerun2.yaml", destination: "/tmp/n98-magerun2.yaml"
  config.vm.provision "file", source: "./scripts/easy-install-m2.sh", destination: "/tmp/easy-install-m2.sh"
  config.vm.provision "file", source: "./scripts/switch-to-php-7.2.sh", destination: "/tmp/switch-to-php-7.2.sh"
  config.vm.provision "file", source: "./scripts/switch-to-php-7.3.sh", destination: "/tmp/switch-to-php-7.3.sh"
  config.vm.provision :shell, path: './provisioning/bootstrap.sh', keep_color: true
  config.vm.provision :shell, path: './provisioning/setup_php_versions.sh', keep_color: true
  config.vm.provision :shell, path: './provisioning/tools.sh', keep_color: true

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = ENV['MEMORY']
    vb.cpus   = ENV['CPUS']
    vb.customize [ "modifyvm", :id, "--audio", "none" ]
  end

end
