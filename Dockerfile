# syntax = docker/dockerfile:1

FROM ruby:3.3.0

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

COPY Gemfile Gemfile.lock ./

EXPOSE 3300

WORKDIR /app

COPY . /app

RUN gem install bundler

RUN bundle install
