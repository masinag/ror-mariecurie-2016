#### Logging in as a User
We need a system for our application in order to **authenticate** the users. For web based applications, such a system has to be based onto **cookies**.

In order to implement this feature quickly and not get bogged into implementation details, we will use the `sorcery` gem.

In the app's Gemfile:
```ruby
gem 'sorcery'
```
then run `bundle install`.

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

Now run the migration

```sh
rake db:migrate
```
