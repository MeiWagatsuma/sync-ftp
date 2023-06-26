#!/bin/bash

# Config
env_file=".env"
ftp_dir="/synctest"
local_dir="./sync-dir"
log_file="log.txt"

# Load .env file
if [ -f "$env_file" ]; then
  export $(grep -v '^#' "$env_file" | xargs)
fi

# You should set environment variable in .env file
ftp_domain=$FTP_DOMAIN
username=$USERNAME
password=$PASSWORD


# util: get now date 
get_current_date() {
	# format: YYYY-MM-DD HH:MM:SS
  date +'%Y-%m-%d %H:%M:%S'
}

# if not exists log_file, create file
if [ ! -f "$log_file" ]; then
  touch "$log_file"

	# Log 
  echo "$(get_current_date) [ Info  ]: Created log file : $log_file" >> "$log_file"
fi

# if not exists local_dir, create dirctory
if [ ! -d "$local_dir" ]; then
  mkdir -p "$local_dir"

	# Log
  echo "$(get_current_date) [ Info  ]: Created directory: $local_dir" >> "$log_file"
fi


# download from FTP
lftp -u "$username","$password" "$ftp_domain" << EOF
cd $ftp_dir
lcd $local_dir  
mget *   
bye 
EOF


# Log 
if [ "$?" -eq 0 ]; then
  echo "$(get_current_date) [Success] Files downloaded." >> "$log_file"
else
  echo "$(get_current_date) [ Error ] Failed to download files." >> "$log_file"
fi
