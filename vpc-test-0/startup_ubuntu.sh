#! /bin/bash
echo "Hola - Ubuntu" > /tmp/hola.txt
apt-get update
apt-get install -y nginx-light
apt-get install -y net-tools
cat <<EOF > /var/www/html/index.html
<html><body><p>welcome to $(hostname).</p></body></html>
EOF