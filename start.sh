#!/bin/bash

# start required services
/etc/init.d/php5-fpm start
/etc/init.d/nginx start
mysqld_safe &

# clone repo
if [ ! $REPO ];
then
  REPO="https://github.com/joomla/joomla-cms.git"
fi;

# fetch joomla installation
git clone $REPO /usr/share/nginx/www/joomla-cms

# paste unit test config
cp /configdef.php /usr/share/nginx/www/joomla-cms/tests/system/servers/configdef.php

# set correct owner
chown -R www-data:www-data /usr/share/nginx/www/joomla-cms

# start Xvfb
if [ ! $RESOLUTION ];
then
  RESOLUTION="1024x768x24"
fi;

echo "Running Xvfb at $RESOLUTION"

nohup /usr/bin/Xvfb :99 -ac -screen 0 $RESOLUTION &
export DISPLAY=:99.0

# starting selenium
nohup java -jar selenium-server.jar &

cd /usr/share/nginx/www/joomla-cms/tests/system/webdriver/tests
phpunit -c phpunit.xml.dist
