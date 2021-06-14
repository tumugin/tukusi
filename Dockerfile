FROM ruby:3.0.1

WORKDIR /app_prepare

COPY ./Gemfile /app_prepare/
COPY ./Gemfile.lock /app_prepare/
RUN gem install bundler
RUN bundle install

WORKDIR /app
