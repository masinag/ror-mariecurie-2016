#!/bin/sh

rbenv uninstall $(rbenv global)
rbenv install 2.2.4

gem install rails bundler rspec