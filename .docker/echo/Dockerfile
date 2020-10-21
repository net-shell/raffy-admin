FROM node:latest

RUN apt-get update \
	&& apt-get install -y python make g++ gcc \
	&& npm i -g laravel-echo-server

WORKDIR /usr/src/app

ENTRYPOINT ["laravel-echo-server"]
CMD ["start"]
