FROM debian:bullseye-slim
MAINTAINER Steven Saus (steven@faithcollapsing.com)

ENV DEBIAN_FRONTEND noninteractive

# Install packages
RUN apt-get update -y && \
    apt-get install -y curl \
    libapache2-mod-php7.4 \
    libphp7.4-embed \
    php7.4 \
    php7.4-common \
    php7.4-bcmath \
    php7.4-bz2 \
    php7.4-cgi \
    php7.4-cli \
    php7.4-common \
    php7.4-curl \
    php7.4-fpm \
    php7.4-gd \
    php7.4-gmp \
    php7.4-imap \
    php7.4-interbase \
    php7.4-intl \
    php7.4-json \
    php7.4-ldap \
    php7.4-mbstring \ 
    php7.4-mysql \
    php7.4-odbc \
    php7.4-opcache \ 
    php7.4-pgsql \
    php7.4-phpdbg \
    php7.4-pspell \
    php7.4-readline \
    php7.4-soap \
    php7.4-sqlite3 \
    php7.4-sybase \
    php7.4-tidy \
    php7.4-xml \ 
    php7.4-xmlrpc \
    php7.4-zip && \
    apt clean && \
    apt autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php/ && mkdir -p /etc/apache2/{conf-available,mods-available}
COPY build/conf-available/ /etc/apache2/conf-available
COPY build/mods-available/ /etc/apache2/mods-available
COPY build/run-httpd /usr/local/bin/
RUN chmod 755 /usr/local/bin/run-httpd


EXPOSE 80
CMD ["/usr/local/bin/run-httpd"]

# THIS LOOKS INTRIGUING
# https://github.com/julianbrowne/apache-anywhere

# build with 
# docker build -t apache2_php7_4 .
# run with
# docker run -d apache2_php7_4
# docker ps
# docker kill 8defbf68cc79
# docker run -it apache2_php7_4 /bin/bash
# will pull in various config files, then at runtime for dyn conversion
# in fact, maybe have a startpoint to check for those and recreate them out
# of the container a la like what roundcube did.
# docker apache2_php7_4 -d 
# -it 
# --name container 
# --mount type=bind,source=/apache_config,target=/etc/apache2
# --mount type=bind,source=/www,target=/etc/www
