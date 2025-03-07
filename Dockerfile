# FROM ruby:2.3
# Doesn't build puma with ruby:2.3 image
FROM cr.yandex/crptb586h3j8u2bd3hru/tb-dbi:1.0.5

ENV LANG C.UTF-8  

RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN bundle install --without development test

COPY . /usr/src/app

EXPOSE 9292

CMD ["/usr/local/bin/bundle", "exec", "puma"]
