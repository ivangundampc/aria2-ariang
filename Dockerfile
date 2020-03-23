FROM alpine:latest

MAINTAINER ivangundampc <ivangundampc@gmail.com>

## download dependencies for aria2c
RUN apk update \
	&& apk add --no-cache gcc g++ zlib-dev openssl-dev expat-dev sqlite-dev c-ares-dev libssh2-dev axel\
	&& mkdir -p aria2/conf aria2/conf-temp aria2/downloads \
	&& axel -a -n 16 https://github.com/ivangundampc/aria2/releases/download/release-1.35.0/aria2c.tar.gz \
	&& tar -zxvf aria2c.tar.gz -C aria2 \
	&& rm aria2c.tar.gz

## download aria-ng and install darkhttpd
RUN apk add --no-cache --update darkhttpd \
	&& mkdir -p aria-ng \
	&& axel -a -n 16 https://github.com/mayswind/AriaNg/releases/download/1.1.1/AriaNg-1.1.1.zip \
	&& unzip AriaNg-1.1.1.zip -d aria-ng \
	&& rm AriaNg-1.1.1.zip \
	&& apk del axel

COPY init.sh /aria2/init.sh
COPY conf-temp /aria2/conf-temp

WORKDIR /
VOLUME ["/aria2/conf", "/aria2/downloads"]
EXPOSE 6800 80 8080

CMD ["/aria2/init.sh"]
