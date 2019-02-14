FROM ruby:2.6.1

RUN apt-get update -qq && apt-get install -y locales

WORKDIR /usr/src/insta_favotter

COPY . .

RUN gem install bundler && bundle install

