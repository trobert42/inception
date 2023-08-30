#!/bin/bash

sleep 28

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
	echo "Wordpress configuration..."
	wp config create --allow-root \
			--dbname=${WP_DATABASE} \
			--dbuser=${MYSQL_USER} \
			--dbpass=${MYSQL_USER_PWD} \
			--dbhost=mariadb:3306 --path=${WP_PATH}

	wp core install --allow-root \
			--url=${URL} \
			--title=${PROJECT_NAME} \
			--admin_user=${WP_ADMIN_USER} \
			--admin_password=${WP_ADMIN_USER_PWD} \
			--admin_email=${WP_ADMIN_USER_MAIL} \
			--skip-email \
			--path=${WP_PATH}

	wp user create --allow-root \
			${WP_USER} ${WP_USER_MAIL} \
			--user_pass=${WP_USER_PWD} \
			--role=editor \
			--path=${WP_PATH}

else
	echo "Wordpress already installed and configured"
fi

if [ ! -d "/run/php" ]; then
	mkdir /run/php
fi

echo "Done configurating wordpress!"
/usr/sbin/php-fpm7.3 -F
