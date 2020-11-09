# OSBB
* Development branch
[![Build Status](https://travis-ci.com/IF-115-Ruby/OSBB.svg?branch=development)](https://travis-ci.com/github/IF-115-Ruby/OSBB)
[![Maintainability](https://api.codeclimate.com/v1/badges/255b30c06fbade0f3bdc/maintainability)](https://codeclimate.com/github/IF-115-Ruby/OSBB/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/255b30c06fbade0f3bdc/test_coverage)](https://codeclimate.com/github/IF-115-Ruby/OSBB/test_coverage)
## Prerequisites

### To run the project you need:

  [Ruby v.2.7.1](https://rvm.io/rubies/installing)

  [Yarn v.1.22.5-1](https://classic.yarnpkg.com/en/docs/install/#debian-stable)

  [Node.js v.10.19.0](https://linuxize.com/post/how-to-install-node-js-on-ubuntu-18.04/#installing-nodejs-and-npm-from-nodesource)

    PostgreSQL v.12 ( sudo apt install postgresql-12 )
    Redis (sudo apt install redis-server)

## Install

### Clone the repository

```shell
git clone https://github.com/IF-115-Ruby/OSBB.git
cd OSBB
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and [Yarn](https://github.com/yarnpkg/yarn):

```shell
bundle && yarn
```

### Initialize the database

```shell
rails db:create db:migrate db:seed
```

### Copy file `.env.template` and rename it to `.env` and add values in environment variables

## Server

```shell
rails s
sidekiq
```

## Contributing
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D
