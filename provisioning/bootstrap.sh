#!/usr/bin/env bash
# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo "* Installing " $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

echo "* Adding swap file..."
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap defaults 0 0' >> /etc/fstab

# Prevents "Warning: apt-key output should not be parsed (stdout is not a terminal)".
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

echo "* Refreshing software repositories..."
apt-get -y update >/dev/null 2>&1

# Install dependencies
install 'Development tools' build-essential

install 'Git' git
install 'Apache' apache2
install 'MySQL' mysql-server
install 'Unzip' unzip

echo "* Configuring Dynamic hosts..."
# Copy dynamic vhosts to VM
mv /tmp/dynamic-vhosts_vhost_alias.conf /etc/apache2/sites-available/dynamic-vhosts_vhost_alias.conf
ln -s /etc/apache2/sites-available/dynamic-vhosts_vhost_alias.conf /etc/apache2/sites-enabled/dynamic-vhosts_vhost_alias.conf

echo "* Enabling dynamic hosts Apache module..."
# Enable dynamic vhost / mod_rewrite module on Apache
a2enmod vhost_alias
a2enmod rewrite
service apache2 restart

echo "* Configuring php-switch scripts..."
mv /tmp/switch-to-php* /usr/local/bin
chmod +x /usr/local/bin/switch-to-php*

echo "* Copying easy-intall-m2 to /usr/local/bin..."
mv /tmp/easy-intall-m2.sh /usr/local/bin/m2-install.sh
chmod +x /usr/local/bin/m2-install.sh

echo "* Adding vagrant user to www-data group..."
# Add user vagrant to www-data group
usermod -aG www-data vagrant

echo "* Enabling MySQL access from host..."
# Enable access to host to MySQL
sed -i 's/skip-external-locking/#skip-external-locking/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf
systemctl restart mysql.service

sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root'"
sudo mysql -uroot -proot -e "FLUSH PRIVILEGES"