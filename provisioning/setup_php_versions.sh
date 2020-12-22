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

install "PHP 7.2..." php7.2 php7.2-common php7.2-cli

install "PHP 7.2 extensions..." php7.2-bz2 php7.2-curl php7.2-gd php7.2-json php7.2-mbstring php7.2-mysql php7.2-opcache php7.2-readline php7.2-soap php7.2-sqlite3 php7.2-tidy php7.2-xml php7.2-xsl php7.2-zip php7.2-intl php7.2-bcmath php7.2-dev

install "PHP 7.3..." php7.3 php7.3-common php7.3-cli

install "PHP 7.3 extensions..." php7.3-bz2 php7.3-curl php7.3-gd php7.3-json php7.3-mbstring php7.3-mysql php7.3-opcache php7.3-readline php7.3-soap php7.3-sqlite3 php7.3-tidy php7.3-xml php7.3-xsl php7.3-zip php7.3-intl php7.3-bcmath php7.3-dev

install "additional PHP extensions..." php-memcache php-memcached php-redis php-xdebug php-intl
