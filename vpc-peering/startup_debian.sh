#! /bin/bash
echo "Hola - Debian" > /tmp/hola.txt
apt-get update
apt-get install -y dnsutils  
apt-get install -y nginx-light
# apt-get install -y net-tools  (in path using sudo)
cat <<EOF > /var/www/html/index.html
<html><body><p>welcome to $(hostname).</p></body></html>
EOF