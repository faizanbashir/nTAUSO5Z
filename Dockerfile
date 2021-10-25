FROM ruby:3.0.2

RUN mkdir /usr/src/app

RUN adduser --no-create-home www

USER www

ADD server /usr/src/app/

WORKDIR /usr/src/app/

CMD ["ruby", "http_server.rb"]