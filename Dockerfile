FROM ubuntu:12.04
RUN apt-get update && apt-get install -y cron && apt-get install -y curl sudo git rsync build-essential wget ruby1.9.1 rubygems1.9.1 python-software-properties php5-fpm nginx php5-cli php5-mysql mysql-server mysql-client php5 php5-curl && curl -L https://www.opscode.com/chef/install.sh | bash && wget -O - https://github.com/travis-ci/travis-cookbooks/archive/master.tar.gz | tar -xz && mkdir -p /var/chef/cookbooks && cp -a travis-cookbooks-master/ci_environment/* /var/chef/cookbooks
RUN apt-get -y install socat
RUN adduser travis --disabled-password --gecos ""
RUN mkdir /home/travis/builds
ADD travis.json travis.json
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN chmod 777 /tmp
RUN echo 'travis ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN chef-solo -o java,xserver,firefox::default,chromium -j travis.json
RUN wget http://selenium-release.storage.googleapis.com/2.44/selenium-server-standalone-2.44.0.jar -O selenium-server.jar
RUN wget https://phar.phpunit.de/phpunit.phar && chmod +x phpunit.phar && mv phpunit.phar /usr/local/bin/phpunit
ADD start.sh start.sh
ADD default /etc/nginx/sites-enabled/default
ADD configdef.php configdef.php
CMD bash start.sh
EXPOSE 80
EXPOSE 4444