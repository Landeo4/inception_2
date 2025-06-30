#!/bin/bash

mysqld_safe &

until mysqladmin ping --silent; do
    echo 'En attente de MariaDB...'
    sleep 2
done

echo "Environment variables are set:"
echo "SQL_DATABASE: $SQL_DB"
echo "SQL_USER: $SQL_USR"
echo "SQL_PASSWORD: $SQL_PASS"
echo "SQL_ROOT_PASSWORD: $SQL_ROOTPASS"

# Essayer de se connecter sans mot de passe pour changer le mot de passe root
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOTPASS}'; FLUSH PRIVILEGES;" 2>/dev/null || true

# Puis créer base et utilisateur, connexion avec mot de passe root
mysql -u root -p"${SQL_ROOTPASS}" <<EOSQL
CREATE DATABASE IF NOT EXISTS \`${SQL_DB}\`;
CREATE USER IF NOT EXISTS \`${SQL_USR}\`@'%' IDENTIFIED BY '${SQL_PASS}';
GRANT ALL PRIVILEGES ON \`${SQL_DB}\`.* TO \`${SQL_USR}\`@'%';
FLUSH PRIVILEGES;
EOSQL

mysqladmin -u root -p"${SQL_ROOTPASS}" shutdown

exec mysqld_safe
