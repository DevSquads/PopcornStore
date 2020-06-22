FROM ruby:2.7.1

WORKDIR /opt/PopcornStore

RUN apt install default-libmysqlclient-dev

COPY ./Gemfile* ./
RUN bundle install
COPY ./ ./

ENTRYPOINT ["tail", "-f", "/dev/null"]