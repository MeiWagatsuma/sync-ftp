#!/bin/bash
#
env_file=".env"

# Load .env file
if [ -f "$env_file" ]; then
  export $(grep -v '^#' "$env_file" | xargs)
fi

# You should set environment variable in .env file
ftp_domain=$FTP_DOMAIN
username=$USERNAME
password=$PASSWORD

lftp "ftp://"$username":"$password"@"$ftp_domain

