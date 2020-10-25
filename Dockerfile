FROM ruby:2.6.5
RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y postgresql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get install -y libsox-fmt-all sox libchromaprint-dev

WORKDIR /Biitos

ADD Gemfile /Biitos/Gemfile
ADD Gemfile.lock /Biitos/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /Biitos
