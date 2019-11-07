#!bin/bash
set -e
set -x
apt-get update
apt-get install -y wget unzip mysql-client git patch

# Install composer
wget https://getcomposer.org/installer -O /tmp/composer-install

php /tmp/composer-install --install-dir=/usr/bin --filename=composer

# Install drush & security-checker
## Temporarily pin to version 8.2.3... 
composer global require drush/drush:8.2.3 sensiolabs/security-checker
# Touch up
ln -s /usr/bin/composer /usr/local/bin/composer
ln -s $(realpath ~/.composer/vendor/bin/drush) /usr/local/bin/drush
chmod +x /usr/bin/composer
drush @none dl registry_rebuild-7.x

apt-get clean
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
rm -Rf /root/.composer/cache