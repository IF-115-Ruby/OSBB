# README
# OSBB

## Prerequisites

### To run the project you need:

  [Ruby v.2.7.1](https://rvm.io/rubies/installing)

  [Yarn v.1.22.5-1](https://classic.yarnpkg.com/en/docs/install/#debian-stable)
  
  [Node.js v.10.19.0](https://linuxize.com/post/how-to-install-node-js-on-ubuntu-18.04/#installing-nodejs-and-npm-from-nodesource)
    
    PostgreSQL v.12 ( sudo apt install postgresql-12 )

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

## Server

```shell
rails s
```

* Development branch
[![Build Status](https://travis-ci.com/IF-115-Ruby/OSBB.svg?branch=development)](https://travis-ci.com/github/IF-115-Ruby/OSBB)

