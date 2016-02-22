# Ruby on Rails Basics 1

## The environment

In order to see which version of Ruby is installed in you system let's open a terminal and type:
~~~bash
$ ruby -v
ruby 2.0.0p481 (2014-05-08 revision 45883)
~~~

Of course you can type the same for Rails:
~~~bash
$ rails -v
Rails 4.2.5.1
~~~

As you already know, Rails is a Ruby gem. And it is not the only one you have installed. Please type the following:
~~~bash
gem list
~~~
A bunch of gems will appear in the list, look: Rails is one of them.

Now, let's create a new web application from scratch. Use `rails new` command in order to do it.
~~~bash
$ rails new testproject
  create  
  create  README.rdoc
  create  Rakefile
  create  config.ru
  create  .gitignore
  create  Gemfile
  [...]
~~~

This command will create a folder named `testproject` in which you will find all the files needed in order to run your first web application.
Please, type `cd` in order to see what are these files.

~~~bash
$ cd testproject
$ atom .
~~~

As you can see, there are a set of directories and files. Let's have a look on them.

~~~bash
app/
~~~
It is the core of you web application. In fact, it contains the controllers, models, views, helpers, mailers and assets for your application.

~~~bash
bin/
~~~
Contains the rails script that starts your app and can contain other scripts you will use to setup, deploy or run your application.

~~~bash
config/
~~~
You will use it in order to configure your application's routes, database, and more.

~~~bash
config.ru
~~~
Rack configuration for Rack based servers used to start the application.

~~~bash
db/
~~~
It contains your current database schema, as well as the database migrations.

~~~bash
Gemfile and Gemfile.lock
~~~
These files allow you to specify what gem dependencies are needed for your Rails application. These files are used by the Bundler gem.

~~~bash
lib/
~~~
Extended modules for your application.

~~~bash
log/
~~~
Application log files.

~~~bash
public/
~~~
The only folder seen by the world as-is. Contains static files (e.g. error pages) and compiled assets.

~~~bash
Rakefile
~~~
This file locates and loads tasks that can be run from the command line. The task definitions are defined throughout the components of Rails. Rather than changing Rakefile, you should add your own tasks by adding files to the lib/tasks directory of your application.

~~~bash
README.rdoc
~~~
This is a brief instruction manual for your application. You should edit this file to tell others what your application does, how to set it up, and so on.

~~~bash
test/
~~~
Unit tests, fixtures, and other test apparatus. Files within this folder are used in order to test your application in the validation step of your development process.

~~~bash
tmp/
~~~
Temporary files (like cache, pid, and session files).

~~~bash
vendor/
~~~
A place for all third-party code. In a typical Rails application this includes vendored gems.

## Running you web application

Now, we have seen the basics structure of a web application in Ruby on Rails. In order to run it, let's use the `rails server` command. Remember that you need to run this command within the root folder of your application (testproject in our case).

~~~bash
$ rails server
~~~

The Rails web server is started, please visit http://localhost:3000 in order to see the homepage of your first web application.

## Useful commands: scaffold

Rails gives to developers lots of shortcuts in order to generate automatically pieces of code through commands. One of these is the `generate scaffold`, which allows to generate one model, one controller, some views (and other useful files) for a specific resource. In the following example we want to generate all the needed files in order to allows our application to handle users specified by two attributes: name and surname, both strings.

~~~bash
$ rails generate scaffold User name:string surname:string
~~~

Note: while in some files the name of classes are singular (as written in the command), in some others they are written in the plural form. Is it magic?
