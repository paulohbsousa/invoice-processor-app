# syntax=docker/dockerfile:1
FROM ruby:3.3.5

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs npm

WORKDIR /app

RUN gem install bundler

COPY Gemfile* ./

RUN bundle install

ADD . /app

#RUN bin/rails db:create
#RUN bin/rails db:migrate

EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]