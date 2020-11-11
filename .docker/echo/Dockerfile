FROM node:latest

RUN apt-get update \
	&& apt-get install -y python make g++ gcc \
	&& npm i -g laravel-echo-server \
	&& pip install supervisor

COPY laravel-echo.conf /etc/supervisor/conf.d/laravel-echo.conf

# Lets reload the configuration and start the daemon
RUN sudo supervisorctl reread \
    && sudo supervisorctl restart all

WORKDIR /app

ENTRYPOINT ["laravel-echo-server"]
CMD ["start"]
