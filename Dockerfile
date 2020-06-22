FROM ruby:2.7.1

WORKDIR /opt/PopcornStore

RUN apt install default-libmysqlclient-dev
RUN apt-get update && apt-get install -y netcat

COPY ./Gemfile* ./
RUN bundle install
COPY ./ ./

EXPOSE $APPLICATION_PORT

## Add the wait script to the image
COPY wait.sh /wait.sh
RUN chmod +x /wait.sh

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]