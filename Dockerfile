FROM ruby:2.7.1

RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt update -qq && apt install -y \
  build-essential \
  libpq-dev \
  imagemagick \
  nodejs \
  yarn

RUN mkdir  /app
WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install --jobs 5

COPY package.json .
COPY yarn.lock .
RUN yarn install
RUN bin/rails assets:precompile

