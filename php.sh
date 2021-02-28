#!/bin/bash

rm /etc/alternatives/php
ln -s /usr/bin/php"$PHP_VERSION" /etc/alternatives/php
service apache2 restart
source mysql.sh
/bin/bash    

