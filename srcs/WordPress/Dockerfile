FROM debian:bullseye

RUN apt-get update
RUN apt-get upgrade
RUN apt-get -y install wget
RUN apt-get install -y php7.3 php-fpm php-mysql mariadb-client
RUN wget https://fr.wordpress.org/wordpress-6.8.1-fr_FR.tar.gz -P /var/www
RUN tar -xvf /var/www/wordpress-6.8.1-fr_FR.tar.gz -C /var/www
RUN	chown -R root:root /var/www/wordpress
RUN make /compose.yml
# copier fichier vers ici