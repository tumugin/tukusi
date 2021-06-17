FROM ruby:3.0.1

WORKDIR /app_prepare

RUN gem install bundler debase ruby-debug-ide
COPY Gemfile Gemfile.lock ./
RUN bundle install

WORKDIR /app
