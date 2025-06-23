FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y
RUN apt-get install mariadb-server -y
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./conf/config.sh
RUN chmod +x ./conf/config.sh

RUN chown -R mysql:mysql /var/lib/mysql

RUN mariadb -u root
CMD conf/scrips.sh
ENTRYPOINT ["./config.sh"]