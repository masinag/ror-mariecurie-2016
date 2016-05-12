# Authentication
We need a system for our application in order to **authenticate** the users. For web based applications, such system has to be based onto **cookies**.

### Managing dependencies, trough `bundle`
In order to implement this feature quickly and not get bogged into implementation details, we will use the **sorcery** gem.

In the app's Gemfile add:
```ruby
gem 'sorcery'
```
then run `bundle install`.

### Creating the model

We have at our disposal a generator added by sorcery:
```sh
rails g sorcery:install
```
It will create the initializer file, the User model, and the default migration, which we want to run after we have customized it a bit:

```ruby
class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # sorcery fields
      t.string :email,            :null => false
      t.string :crypted_password
      t.string :salt
      # our fields
      t.string :surname
      t.string :name

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
```

As you can see, this is nothing  but a normal migration with some fields that are expected by sorcery: `email`, `crypted_password`, `salt`.

Now run the migration

```sh
rake db:migrate
```

If we take a look at the model, we see it looks like this:

```ruby
class User < ActiveRecord::Base
  authenticates_with_sorcery!
end
```

As you see there is some **monkey patching** going on; `authenticates_with_sorcery!` is a class method for `ActiveRecord::Base` that is provided by sorcery. This method in particular enhances the `User` class with attributes accessors for the `password` and `password_confirmation` fields, and some other code that computes `crypted_password` right before the model is persisted.

It can be easily tested in the console:

```text
> u = User.new(email: 'notice validation missing!', password: 'dictionary')
=> #<User id: nil, email: "notice validation missing!", crypted_password: nil, salt: nil, created_at: nil, updated_at: nil>
> u.save
   (0.1ms)  begin transaction
  SQL (0.1ms)  INSERT INTO "users" ("email", "salt", "crypted_password", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["email", "notice validation missing!"], ["salt", "pHTJDAFb3ppsZMmFyuPB"], ["crypted_password", "$2a$10$CKc1.ueBPN58XJQlr4cRi.mzgoxwrXdOATsKyoLY3CFDQHUdJGkKW"], ["created_at", "2016-05-12 19:11:52.255689"], ["updated_at", "2016-05-12 19:11:52.255689"]]
   (12.7ms)  commit transaction
=> true
```

Another method added to the `User` class that we will be using later is `valid_password?`. It compares a given string with the actual user's password, returns `true` if they match

```text
> u.valid_password? 'book'
=> false
> u.valid_password? 'dictionary'
=> true
```

Adding some validation to the model fields is a very good idea, and is left as an exercise for the reader. If you are uncertain on how to proceed, here is a tip: only validate `email`, `password`, `name` and `surname`; there's no need to verify that `crypted_password` is OK! Even though `password` is *virtual*, it can be validated like any other field.

### Registering users

Now we want to allow users to register to our web application. For now, a simple form that will accept any valid input will suffice.

To get some views and controllers fast, we'll run rails scaffold generator, and skip the files we already created (we'll need to delete the new migration manually though):

```sh
rails g scaffold user email:string password:string password_confirmation:string name:string surname:string --migration false
```

**DO NOT OVERWRITE THE MODEL!**

We proceed to customize the routes: get rid of `resources :users` for something that is more appropriate:
```ruby
get 'register' => 'users#new'
post 'register' => 'users#create'
```

As you can see, we will be using only the `new` and `create` methods and views.

Since we changed the routes, we no longer have at our disposal some of the urls helper that are used in the newly generate views, in particular:

In the form partial, `views/users/_form.html.erb` change the first line to:
```erb
<%= form_for(register_path) do |f| %>
```
So that the form submits a post to `/register`, according to the routing table

In `views/users/new.html.erb`, get rid of the last line, we don't need it since it's a link to nowhere, and it makes our program crash.

```erb
<%= link_to 'Back', users_path %>
```

If we direct our browser to `http://localhost:3000/register` we should see the registration form. It's ugly, improving it using material design light will be an easy task, and will only modify the views.
