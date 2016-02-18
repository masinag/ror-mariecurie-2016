#!/bin/sh

rbenv uninstall $(rbenv global)
rbenv install 2.2.4
rbenv global 2.2.4
rbenv rehash

gem install rails bundler rspec