MAINTAINER cedric@zestprod.com
FROM ubuntu
RUN apt-get update
RUN apt-get install -y \
  wget \
  php5 \
  php5-mysql \
  php5-ldap \
  # php5-imap \
  php5-xmlrpc \
  curl \
  php5-curl \
  php5-gd
RUN apt-get install -y apache2
RUN a2enmod rewrite && service apache2 restart
WORKDIR /var/www/html
COPY htaccess /usr/local/apache2/htdocs/.htaccess
COPY start.sh /opt/
RUN chmod +x /opt/start.sh
CMD /opt/start.sh
EXPOSE 80
