#!/bin/sh
echo "installing snapd"
apt install snapd

echo "installing ssm agent"
apt install amazon-ssm-agent --classic

echo "installing docker"
apt install docker.io -y

echo "installing docker-compose"
apt install docker-compose -y

echo "creating docker-compose file"
touch ./docker-compose.yml

cat <<EOF >> ./docker-compose.yml
version: '3.3'

services:
   db:
     image: mysql:5.7
     volumes:
       - db_data:/var/lib/mysql
     restart: always
     environment:
       MYSQL_ROOT_PASSWORD: somewordpress
       MYSQL_DATABASE: wordpress
       MYSQL_USER: wordpress
       MYSQL_PASSWORD: wordpress

   wordpress:
     depends_on:
       - db
     image: wordpress:latest
     ports:
       - "80:80"
     restart: always
     environment:
       WORDPRESS_DB_HOST: db:3306
       WORDPRESS_DB_USER: wordpress
       WORDPRESS_DB_PASSWORD: wordpress
       WORDPRESS_DB_NAME: wordpress
volumes:
    db_data: {}
EOF

echo "running docker containers as daemon"
docker-compose up -d