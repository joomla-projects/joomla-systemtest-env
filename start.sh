#!/bin/bash

# start required services
/etc/init.d/php5-fpm start
/etc/init.d/nginx start
mysqld_safe &

# set repo
if [ ! $REPO ];
then
  REPO="https://github.com/joomla/joomla-cms.git"
fi;

# set branch
if [ ! $BRANCH ];
then
  BRANCH="staging"
fi;

# fetch joomla installation
git clone --branch=$BRANCH $REPO /usr/share/nginx/www/joomla-cms

# paste unit test config
cp /configdef.php /usr/share/nginx/www/joomla-cms/tests/system/servers/configdef.php

# set correct owner
chown -R www-data:www-data /usr/share/nginx/www/joomla-cms

# start Xvfb
if [ ! $RESOLUTION ];
then
  RESOLUTION="1280x1024x24"
fi;

echo "Running Xvfb at $RESOLUTION"

nohup /usr/bin/Xvfb :99 -ac -screen 0 $RESOLUTION &
export DISPLAY=:99.0

sleep 15

# starting selenium
nohup java -jar selenium-server.jar &

sleep 15

cd /usr/share/nginx/www/joomla-cms/tests/system/webdriver/tests
phpunit -c phpunit.xml.dist
