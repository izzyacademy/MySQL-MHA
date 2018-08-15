#!/bin/bash

MYSQL_SERVER_PASS="$1"

TARGET_MYSQL_SCRIPT_FILE="/root/create-users.sql"

MYSQL_PASS="$1"

if [[ "${MYSQL_PASS}" =~ ([A-Z]{1,}) ]]; 
then 
  echo "Password ${MYSQL_PASS} contains an uppercase letter" ; 
else 
  echo "Password ${MYSQL_PASS} does not contain an upper case letter"; 
  exit 1
fi

if [[ "${MYSQL_PASS}" =~ ([a-z]{1,}) ]]; 
then 
  echo "Password ${MYSQL_PASS} contains a lowercase letter" ; 
else 
  echo "Password ${MYSQL_PASS} does not contain a lowercase letter"; 
  exit 1
fi

if [[ "${MYSQL_PASS}" =~ ([0-9]{1,}) ]]; 
then 
  echo "Password ${MYSQL_PASS} contains a number" ; 
else 
  echo "Password ${MYSQL_PASS} does not contain a number"; 
  exit 1
fi

if [[ "${MYSQL_PASS}" =~ ([^\s]{1,}) && "${MYSQL_PASS}" =~ ([^A-Za-z0-9]{1,}) ]]; 
then 
  echo "Password ${MYSQL_PASS} contains a special character" ; 
else 
  echo "Password ${MYSQL_PASS} does not contain a special character"; 
  exit 1
fi

if [[ "${MYSQL_PASS}" =~ ([^\s]{8,}) ]]; 
then 
  echo "Password ${MYSQL_PASS} is up to 8 characters" ; 
else 
  echo "Password ${MYSQL_PASS} is not up to 8 characters"; 
  exit 1
fi

echo "Username is ${MYSQL_SERVER_USER}"
echo "Password is ${MYSQL_SERVER_PASS}"

echo "" > $TARGET_MYSQL_SCRIPT_FILE
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_SERVER_PASS}';" >> $TARGET_MYSQL_SCRIPT_FILE
echo "" >> $TARGET_MYSQL_SCRIPT_FILE

mysql --connect-expired-password < ${TARGET_MYSQL_SCRIPT_FILE}




MYSQL_SERVER_ROOT_USER="root"

MYSQL_SERVER_ROOT_PASS="$1"

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


