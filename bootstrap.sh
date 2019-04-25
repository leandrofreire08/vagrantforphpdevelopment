#!/usr/bin/env bash
# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

echo adding swap file
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap defaults 0 0' >> /etc/fstab

# Prevents "Warning: apt-key output should not be parsed (stdout is not a terminal)".
export APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# Add PHP repository
add-apt-repository -y ppa:ondrej/php

echo updating package information
apt-get -y update >/dev/null 2>&1

# Install dependencies
install 'Development tools' build-essential

install 'Git' git
install 'Apache' apache2
install 'MariaDB' mariadb-server

# Install PHP 7.1
install 'PHP 7.1 + Dependencies' php7.1 libapache2-mod-php7.1 php7.1-common php7.1-gd php7.1-mysql php7.1-curl php7.1-intl php7.1-xsl php7.1-mbstring php7.1-zip php7.1-bcmath php7.1-iconv php7.1-soap

# Install PHP 5.6
install 'PHP 5.6 + Dependencies' php5.6 libapache2-mod-php5.6 php5.6-common php5.6-gd php5.6-mysql php5.6-curl php5.6-intl php5.6-xsl php5.6-mbstring php5.6-zip php5.6-bcmath php5.6-iconv php5.6-soap

mv /tmp/dynamic-vhosts_vhost_alias.conf /etc/apache2/sites-available/dynamic-vhosts_vhost_alias.conf
ln -s /etc/apache2/sites-available/dynamic-vhosts_vhost_alias.conf /etc/apache2/sites-enabled/dynamic-vhosts_vhost_alias.conf

a2enmod vhost_alias
service apache2 restart

echo 'all set, rock on!'
