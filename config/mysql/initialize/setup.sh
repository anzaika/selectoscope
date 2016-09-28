#!/bin/bash
set -e
set -x

service mysql start
until mysqladmin ping &>/dev/null; do
  echo -n "."; sleep 1
done
mysql -uroot -p1234 -e "GRANT ALL ON *.* TO 'root'@'%' identified by '1234'"
service mysql stop
