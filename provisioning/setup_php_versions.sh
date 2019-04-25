#!/bin/bash

function install {
    echo "* Installing " $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

echo "* Refreshing software repositories..."
apt-get -y update >/dev/null 2>&1

install "prerequisite software packages..." software-properties-common

echo "* Setting up third-party repository to allow installation of multiple PHP versions..."
add-apt-repository -y ppa:ondrej/php >/dev/null 2>&1

echo "* Refreshing software repositories..."
apt-get -y update >/dev/null 2>&1

install "PHP 5.6..." php5.6 php5.6-common php5.6-cli

install "PHP 5.6 extensions..." php5.6-curl php5.6-mcrypt php5.6-soap php5.6-bz2 php5.6-gd php5.6-mysql php5.6-sqlite3 php5.6-json php5.6-opcache php5.6-xml php5.6-mbstring php5.6-readline php5.6-xmlrpc php5.6-zip php-redis php5.6-intl php5.6-bcmath

install "PHP 7.0..." php7.0 php7.0-common php7.0-cli

install "PHP 7.0 extensions..." php7.0-gd php7.0-mysql php7.0-sqlite3 php7.0-soap php7.0-xsl php7.0-json php7.0-opcache php7.0-mbstring php7.0-readline php7.0-curl php7.0-mcrypt php7.0-xml php7.0-zip php-redis php7.0-intl php7.0-bcmath

install "PHP 7.1..." php7.1 php7.1-common php7.1-cli

install "PHP 7.1 extensions..." php7.1-gd php7.1-mysql php7.1-sqlite3 php7.1-soap php7.1-xsl php7.1-json php7.1-opcache php7.1-mbstring php7.1-readline php7.1-curl php7.1-mcrypt php7.1-xml php7.1-zip php-redis php7.1-intl php7.1-bcmath

install "PHP 7.2..." php7.2 php7.2-common php7.2-cli

install "PHP 7.2 extensions..." php7.2-bz2 php7.2-curl php7.2-gd php7.2-json php7.2-mbstring php7.2-mysql php7.2-opcache php7.2-readline php7.2-soap php7.2-sqlite3 php7.2-tidy php7.2-xml php7.2-xsl php7.2-zip php7.2-intl php7.2-bcmath

install "PHP 7.3..." php7.3 php7.3-common php7.3-cli

install "PHP 7.3 extensions..." php7.3-bz2 php7.3-curl php7.3-gd php7.3-json php7.3-mbstring php7.3-mysql php7.3-opcache php7.3-readline php7.3-soap php7.3-sqlite3 php7.3-tidy php7.3-xml php7.3-xsl php7.3-zip php7.3-intl php7.3-bcmath

install "additional PHP extensions..." php-memcache php-memcached php-redis php-xdebug php-intl
