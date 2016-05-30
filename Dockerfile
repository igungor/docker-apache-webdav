FROM debian:jessie

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_RUN_DIR /var/run/apache2

RUN apt-get update && \
    apt-get install -y apache2 && \
    a2enmod dav dav_fs && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /var/lock/apache2 && \
    chown -R $APACHE_RUN_USER:$APACHE_RUN_GROUP /var/www && \
    chmod -R a+rw /var/www

COPY webdav.conf /etc/apache2/sites-available/

RUN a2ensite webdav && \
    a2dissite 000-default

VOLUME /var/www
EXPOSE 80
CMD apache2 -DFOREGROUND
