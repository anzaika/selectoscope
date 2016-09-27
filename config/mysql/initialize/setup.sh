#!/bin/bash

# Initialize MySQL database.
# ADD this file into the container via Dockerfile.
# Assuming you specify a VOLUME ["/var/lib/mysql"] or `-v /var/lib/mysql` on the `docker run` command…
# Once built, do e.g. `docker run your_image /path/to/docker-mysql-initialize.sh`
# Again, make sure MySQL is persisting data outside the container for this to have any effect.

set -e
set -x

# Start the MySQL daemon in the background.
# /usr/sbin/mysqld &
# mysql_pid=$!

# Wait for database to initialize
sleep 10

until mysqladmin ping &>/dev/null; do
  echo -n "."; sleep 1
done

# Permit root login without password from outside container.
mysql -uroot -p1234 -e "GRANT ALL ON *.* TO 'root'@'%'"

# Tell the MySQL daemon to shutdown.
mysqladmin shutdown

# Wait for the MySQL daemon to exit.
# wait $mysql_pid
