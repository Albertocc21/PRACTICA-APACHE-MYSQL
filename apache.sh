sudo apt update

sudo apt install -y apache2 php libapache2-mod-php php-mysql git 
sudo apt install net-tools

git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /var/www/practica1
sudo mv /var/www/practica1/src/* /var/www/practica1
sudo chown -R www-data.www-data /var/www/practica1
sudo chmod 755 /var/www/practica1



cat <<EOL > /var/www/practica1/config.php
<?php
define('DB_HOST', '192.168.20.35');
define('DB_NAME', 'lamp_db');
define('DB_USER', 'alberto');
define('DB_PASSWORD', '1234');

\$mysqli = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

?>
EOL

sudo systemctl enable apache2
sudo systemctl restart apache2