#!/bin/bash

case $MYSQL_VERSION in
                    "8.0")
                          echo "172.16.0.10 mysql_server" >> /etc/hosts
                          ;;
                    "5.7")
                          echo "172.16.0.20 mysql_server" >> /etc/hosts
                          ;;
                    "5.6")
                          echo "172.16.0.30 mysql_server" >> /etc/hosts
                          ;;
                    "5.5") 
                          echo "172.16.0.40 mysql_server" >> /etc/hosts
                          ;;
                    *)
                          echo "Error: Unknown Mysql version"
                          ;;
esac 