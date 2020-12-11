FROM ruby:2.6.5
RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y postgresql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get install -y libsox-fmt-all sox libchromaprint-dev
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install yarn

RUN mkdir /Biitos
WORKDIR /Biitos

ADD Gemfile /Biitos/Gemfile
ADD Gemfile.lock /Biitos/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /Biitos

RUN mkdir -p tmp/sockets
VOLUME /Biitos/public
VOLUME /Biitos/tmp

RUN SECRET_KEY_BASE=placeholder bundle exec rails assets:precompile \
 && yarn cache clean \
 && rm -rf node_modules tmp/cache