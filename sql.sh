sudo apt update


sudo apt install -y mysql-server git net-tools

sudo service mysql start

git clone https://github.com/josejuansanchez/iaw-practica-lamp.git



sudo su
mysql -u root < iaw-practica-lamp/db/database.sql
mysql -u root <<EOF
Use lamp_db;
CREATE USER 'alberto'@'192.168.20.34' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON lamp_db.* TO 'alberto'@'192.168.20.34';
FLUSH PRIVILEGES;
EOF

sudo sed -i 's/^bind-address\s*=.*/bind-address = 192.168.20.35/' /etc/mysql/mysql.conf.d/mysqld.cnf

sudo systemctl restart mysql
