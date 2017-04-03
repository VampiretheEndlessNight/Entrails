#!/usr/bin/env bash
echo "creating tables . . ."
set -e
service mysql start
mysql < /mysql/setup.sql
service mysql stop