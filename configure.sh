#!/bin/bash

sudo apt-get update
sudo apt-get install -y apache2 php5-cli libapache2-mod-php5
sudo rm /etc/apache2/sites-enabled/000-default.conf

sudo mkdir -p  /var/www/html/assg/


cat << EOF > ~/index.php
<?php
echo "Hello ".gethostname();
?>
EOF


cat << EOF > ~/index.html
Hello World!!!
EOF

cat << EOF > ~/app.conf
<VirtualHost *:80>
    DocumentRoot /var/www/html/assg
    ServerName yourdomain.com
    DirectoryIndex index.php index.html

    AliasMatch ^/$ /var/www/html/assg/index.php

    <Directory "/var/www/html/assg">
      Require all granted
    </Directory>
</VirtualHost>

EOF

sudo cp ~/app.conf /etc/apache2/sites-enabled/app.conf
sudo cp ~/index.*  /var/www/html/assg


sudo service apache2 restart


rm index.* app.conf
