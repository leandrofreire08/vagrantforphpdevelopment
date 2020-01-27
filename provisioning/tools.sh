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
php_versions=("5.6" "7.0" "7.1" "7.2" "7.3")

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

# Install phpdebug CLI
curl https://raw.githubusercontent.com/torinaki/phpdebug-cli/master/phpdebug.sh > ~/.phpdebug

cat >~/.bashrc <<EOL
if [ -f ~/.phpdebug ]; then
    . ~/.phpdebug
fi
EOL
