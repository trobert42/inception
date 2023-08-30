#!/bin/bash

if [ ! -f "/var/lib/mysql/.already_init" ]; then
	service mysql start;
	sleep 6
	echo "Mariadb configuration...";
	mysql -e "CREATE DATABASE IF NOT EXISTS \`${WP_DATABASE}\`;"
	mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_USER_PWD}';"
	mysql -e "GRANT ALL PRIVILEGES ON \`${WP_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_USER_PWD}';"
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PWD}';"
	mysql -u root -p${MYSQL_ROOT_PWD} -e "FLUSH PRIVILEGES;"
	mysqladmin -u root -p${MYSQL_ROOT_PWD} shutdown
	echo "Sucess: Database and user created."
	touch /var/lib/mysql/.already_init
else
	echo "Mariadb database already configured"
fi

echo "Done configuring database mariadb!"
exec mysqld_safe
