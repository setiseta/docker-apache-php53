apache-php
===================================

A Docker image based on Ubuntu 14.04, serving the old PHP 5.3 running as Apache Module. Useful for Web developers in need for an old PHP version.

Tags
-----

* latest: Ubuntu 14.04 (LTS), Apache 2.2, PHP 5.3.29

Usage
------

```
NAME="php52"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
docker run -d \
    -p 80:80 \
    -v $DIR/data/webapp:/home/www/ \
    -v $DIR/data/vhost:/etc/httpd/vhost.d \
    -v $DIR/php.ini:/etc/php.ini \
    --restart=always \
    --name $NAME \
    seti/php53
```
### Access apache logs

Apache is configured to log both access and error log to STDOUT. So you can simply use `docker logs` to get the log output:

`docker logs -f container-id`
