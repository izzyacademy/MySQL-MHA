#!/bin/bash

MYSQL_SERVER_ROOT_USER="root"

MYSQL_SERVER_ROOT_PASS=`cat /var/log/mysqld.log | grep "A temporary password is generated for root@localhost:" | grep -oP "root[@]localhost[:]\s+\K\S+" |  tr -d "\n"`

TARGET_MYSQL_CONFIG_FILE="/root/.my.cnf"

echo ""
echo ""
echo "Replacing username with ${MYSQL_SERVER_ROOT_USER}"
echo "Replacing password with ${MYSQL_SERVER_ROOT_PASS}"

echo ""
echo ""

echo "# Auto generated configuration file. Do not edit!!!" > $TARGET_MYSQL_CONFIG_FILE
echo "" >> $TARGET_MYSQL_CONFIG_FILE
echo "[client]" >> $TARGET_MYSQL_CONFIG_FILE
echo "user=${MYSQL_SERVER_ROOT_USER}" >> $TARGET_MYSQL_CONFIG_FILE
echo "password=${MYSQL_SERVER_ROOT_PASS}" >> $TARGET_MYSQL_CONFIG_FILE

echo "" >> $TARGET_MYSQL_CONFIG_FILE

echo ""
echo ""
echo "This is the new file contents"
cat ${TARGET_MYSQL_CONFIG_FILE}
