#!/bin/bash

mkdir -p /run/php

cd /var/www/html

if [ ! -f wp-config.php ]; then
  echo "Downloading WordPress..."
  wget https://wordpress.org/latest.tar.gz
  tar -xzf latest.tar.gz
  mv wordpress/* .
  rm -rf wordpress latest.tar.gz

  cp wp-config-sample.php wp-config.php

  sed -i "s/wordpress/${MYSQL_DATABASE}/" wp-config.php
  sed -i "s/tpotilli/${MYSQL_USER}/" wp-config.php
  sed -i "s/tpotilli42./${MYSQL_PASSWORD}/" wp-config.php
  sed -i "s/localhost/mariadb/" wp-config.php
fi


php-fpm7.4 -F