# Install composer: 
echo "* Installing composer..."
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
chmod +x composer.phar && mv composer.phar /usr/local/bin/composer

# Install n98-magerun:
echo "* Installing n98-magerun..."
wget -q https://files.magerun.net/n98-magerun.phar && chmod +x n98-magerun.phar && mv n98-magerun.phar /usr/local/bin/n98m1

# Install n98-magerun2: 
echo "* Installing n98-magerun2..."
wget -q https://files.magerun.net/n98-magerun2.phar && chmod +x n98-magerun2.phar && mv n98-magerun2.phar /usr/local/bin/n98m2

# Copy n98-magerun2 config to the right place
mv /tmp/n98-magerun2.yaml ~/.n98-magerun2.yaml

# Configure xdebug
echo "* Configuring xdebug..."

#php_versions=("5.6" "7.0" "7.1" "7.2" "7.3")
php_versions=("7.2" "7.3")

for version in "${php_versions[@]}"
do
cat >/etc/php/$version/mods-available/xdebug.ini <<EOL
zend_extension=xdebug.so
xdebug.remote_enable=1
xdebug.remote_connect_back=1
xdebug.remote_port=9000
xdebug.scream=0
xdebug.cli_color=1
xdebug.show_local_vars=1
xdebug.idekey=PHPSTORM
EOL
done

echo "* Installing phpdebug..."
# Install phpdebug CLI
curl --silent https://raw.githubusercontent.com/torinaki/phpdebug-cli/master/phpdebug.sh > ~/.phpdebug

cat >~/.bashrc <<EOL
if [ -f ~/.phpdebug ]; then
    . ~/.phpdebug
fi
EOL

# Install IonCube
echo "* Check if ionCube is installed..."
isInstalled=`php -v | grep -i ioncube | wc -w`

if [ $isInstalled = 0 ]
then
	echo "* Installing IonCube..."
	wget -q http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz && mv ioncube_loaders_lin_x86-64.tar.gz /tmp
	tar xzf /tmp/ioncube_loaders_lin_x86-64.tar.gz -C /usr/local

	for version in "${php_versions[@]}"
	do
	echo "zend_extension=/usr/local/ioncube/ioncube_loader_lin_$version.so" >> /etc/php/$version/cli/php.ini
	echo "zend_extension=/usr/local/ioncube/ioncube_loader_lin_$version.so" >> /etc/php/$version/apache2/php.ini
	done
else
	echo "* IonCube already installed, skipping..."
fi

echo "* Restaring Apache..."
sudo service apache2 restart


