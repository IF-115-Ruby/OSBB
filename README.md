# README
# OSBB
## Install

### Clone the repository

```shell
git clone https://github.com/IF-115-Ruby/OSBB.git
cd OSBB
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.7.1`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rvm install 2.7.1
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

## Server

```shell
rails s
```

* Development branch
[![Build Status](https://travis-ci.com/IF-115-Ruby/OSBB.svg?branch=development)](https://travis-ci.com/github/IF-115-Ruby/OSBB)

