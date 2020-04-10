#!/bin/sh

# switch user
echo "Running container with user: `id $USER`"

# Copy default configuration file
if [ ! -f /aria2/conf/aria2.conf ]; then
	cp /aria2/conf-temp/aria2.conf /aria2/conf/aria2.conf
fi

# Add rpc-secret config
if [ $SECRET ]; then
	# check if already exists
	line=$(cat /aria2/conf/aria2.conf | grep rpc-secret)
	if [ -z "$line" ]; then
		echo -e " " >> /aria2/conf/aria2.conf
		echo "rpc-secret=\"${SECRET}\"" >> /aria2/conf/aria2.conf
	fi
fi

if [ ! -f /aria2/conf/on-complete.sh ]; then
	cp /aria2/conf-temp/on-complete.sh /aria2/conf/on-complete.sh
fi

chmod +x /aria2/conf/on-complete.sh
touch /aria2/conf/aria2.session

darkhttpd /aria-ng --port 8080 &
darkhttpd /aria2/downloads --port 8081 &
/aria2/aria2c --conf-path=/aria2/conf/aria2.conf