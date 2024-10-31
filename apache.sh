sudo apt update

sudo apt install -y apache2 php libapache2-mod-php php-mysql git 
sudo apt install net-tools

git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /var/www/practica1
sudo mv /var/www/practica1/src/* /var/www/practica1
sudo chown -R www-data.www-data /var/www/practica1
sudo chmod 755 /var/www/practica1

cd /etc/apache2/sites-avaialble
sudo cp 000-default.conf practica1.conf
sed -i 's/DocumentRoot /var/www/html/DocumentRoot /var/www/practica1/' /etc/apache2/sites-available/practica1.conf
sudo a2ensite practica1.conf
sudo a2dissite 000-default.conf
sudo systemctl restart apache2

cat <<EOL > /var/www/practica1/config.php
<?php
define('DB_HOST', '192.168.20.35');
define('DB_NAME', 'lamp_db');
define('DB_USER', 'alberto');
define('DB_PASSWORD', '1234');

\$mysqli = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

?>
EOL

sudo systemctl restart apache2
