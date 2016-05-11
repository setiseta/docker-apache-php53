FROM ubuntu:14.04
MAINTAINER Seti <seti@setadesign.net>

VOLUME ["/var/www"]

RUN apt-get update && \
    apt-get install -y python-software-properties software-properties-common && \
    add-apt-repository -y ppa:sergey-dryabzhinsky/php53 && \
    apt-get update && \

    apt-get install -y \
      apache2 libapache2-mod-php53 apache2-mpm-prefork \
      php53-common php53-cli php53-mod-gd php53-mod-mysql \
      php53-mod-bcmath php53-mod-calendar php53-mod-bz2 \
      php53-mod-soap php53-mod-xml php53-mod-xmlreader php53-mod-xmlwriter \
      php53-mod-ftp php53-mod-imap php53-mod-dom php53-mod-exif \
      php53-mod-fileinfo php53-mod-gettext php53-mod-gmp php53-mod-json \
      php53-mod-mbstring php53-mod-openssl php53-mod-phar php53-mod-pcntl \
      php53-mod-simplexml php53-mod-curl php53-mod-readline php53-mod-tokenizer \
      php53-mod-wddx php53-mod-xsl postfix && \
      mkdir -p /var/lock/apache2 && mkdir -p /var/run/apache2 && \
      a2dismod mpm_event && a2enmod mpm_prefork

COPY apache_default /etc/apache2/sites-available/000-default.conf
COPY run /usr/local/bin/run

RUN chmod +x /usr/local/bin/run && \
    a2enmod rewrite php53 && \
    rm -rf /etc/php53/cli/conf.d /etc/php53/apache2/conf.d && \
    ln -s /etc/php53/conf.d /etc/php53/cli/conf.d && \
    ln -s /etc/php53/conf.d /etc/php53/apache2/conf.d

EXPOSE 80
CMD ["/usr/local/bin/run"]
