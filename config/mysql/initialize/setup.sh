#!/bin/bash
set -e
set -x

chown 999:999 /var/lib/mysql
service mysql start
until mysqladmin ping &>/dev/null; do
  echo -n "."; sleep 1
done
mysql -uroot -e "GRANT ALL ON *.* TO 'root'@'%' identified by '1234'"
service mysql stop
