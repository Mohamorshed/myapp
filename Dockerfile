FROM python:3.7
RUN apt-get update -y && apt-get install nginx -y

ENV ENVIRONMENT DEV
ENV HOST localhost
ENV PORT 8000
ENV REDIS_HOST 172.17.0.2
ENV REDIS_PORT 6379
ENV REDIS_DB 0



WORKDIR /code/
COPY . /code/
RUN pip install -r requirements.txt
RUN apt-get install redis-server -y
RUN /etc/init.d/redis-server start
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
CMD [ "python", "./manage.py", "runserver", "0.0.0.0:8000", "--settings=mysite.settings.prod" ]
RUN service nginx start
EXPOSE 8000
EXPOSE 80
CMD [ "python", "hello.py" ]


