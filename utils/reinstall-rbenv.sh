#!/bin/sh

cd $HOME;

rm -rf .rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

rbenv install 2.2.4
rbenv global 2.2.4
rbenv rehash

gem install rails bundler rspec
