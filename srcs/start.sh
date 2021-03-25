# Create website folder 
mkdir /var/www/tdaydesite/

# Config Nginx file
rm -rf /etc/nginx/sites-enabled/default
mv ./nginx.config /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/nginx.config /etc/nginx/sites-enabled/
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

# Get SSL certification
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=69/L=Lyon/O=42/CN=tdayde' -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

# Create MySQL DATABASE
service mysql start
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' IDENTIFIED BY 'admin' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

# Install phpMyAdmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv phpMyAdmin-4.9.0.1-all-languages var/www/tdaydesite/phpmyadmin
mv /config.inc.php var/www/tdaydesite/phpmyadmin
mkdir var/www/tdaydesite/phpmyadmin/tmp
chmod 777 /var/www/tdaydesite/phpmyadmin/tmp
chown -R www-data /var/www/tdaydesite/phpmyadmin/tmp
rm -f /phpMyAdmin-4.9.0.1-all-languages.tar.gz

# Install Wordpress
wget -c https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv /wordpress/ /var/www/tdaydesite
mv /wp-config.php /var/www/tdaydesite/wordpress
rm -f /latest.tar.gz

# Start services
service php7.3-fpm start
service nginx start
bash
