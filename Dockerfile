FROM ubuntu:12.04
LABEL maintainer="Seti <seti@setadesign.net>"

VOLUME ["/var/www"]

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y \
        php5 wget apache2 libapache2-mod-php5 apache2-mpm-prefork \
        php5-common php5-cli php5-gd php5-mysql \
        php5-imap php5-gmp php5-curl \
        php5-xsl postfix && \
        mkdir -p /var/lock/apache2 && mkdir -p /var/run/apache2

COPY apache_default /etc/apache2/sites-available/000-default.conf
COPY run /usr/local/bin/run

RUN chmod +x /usr/local/bin/run && \
    a2enmod rewrite php5 && \
    rm -rf /etc/php5/cli/conf.d /etc/php5/apache2/conf.d && \
    ln -s /etc/php5/conf.d /etc/php5/cli/conf.d && \
    ln -s /etc/php5/conf.d /etc/php5/apache2/conf.d

EXPOSE 80
CMD ["/usr/local/bin/run"]
