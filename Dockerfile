FROM phusion/baseimage:0.9.18

MAINTAINER shuaibing.huo@gmail.com

WORKDIR /work/site

COPY composer /usr/local/bin/composer
COPY init.sh /tmp/init.sh
RUN /bin/bash /tmp/init.sh
RUN /bin/rm /etc/nginx/sites-available/default
RUN /bin/rm /etc/nginx/sites-enabled/default

#nginx conf
RUN mkdir /data
RUN mkdir -p /usr/share/nginx/html
RUN mkdir -p /var/log/nginx
ADD nginx.run.sh /etc/service/nginx/run
COPY fastcgi.conf /etc/nginx/fastcgi.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY sites-enabled/* /etc/nginx/sites-enabled/

#php conf

COPY php.ini /etc/service/phpfpm/php.ini
COPY www.conf /etc/service/phpfpm/php-fpm.conf
COPY php7.run.sh /etc/service/phpfpm/run
# optimize

COPY optimize.sh /etc/service/phpfpm/optimize.sh

#crontab 

COPY cron /etc/cron.d/command
RUN chmod 700 /etc/cron.d/command

CMD ["/sbin/my_init"]

EXPOSE 80
