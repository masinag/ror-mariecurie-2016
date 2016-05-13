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

As you see there is some **monkey patching** going on; `authenticates_with_sorcery!` is a class method for `ActiveRecord::Base` that is provided by sorcery. This method in particular enhances the `User` class with attributes accessors for the `password` field, and some other code that computes `crypted_password` right before the model is persisted.

`validates_confirmation_of` is a method from active record, as the name implies it creates a confirmation attribute for `:password`, called `:password_confirmation`; they need to match or the object won't be persisted when calling `save`. You want to add `validates_confirmation_of :password` inside the body of the `User` class, or some nasty errors will follow later.

The functionality of the class can be easily tested in the console:

```text
> u = User.new(email: 'notice validation missing!', password: 'dictionary', password_confirmation: 'dictionary')
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

Adding some validation to the model fields is a very good idea, and is left as an exercise for the reader. If you are uncertain on how to proceed, here is a tip: only validate `email`, `password`, `name` and `surname`; there's no need to verify that `crypted_password` is OK! Even though `password` is *virtual*, it can be validated like any other field. If will be easier to test the validation later, when we have some forms up and running!

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

Now it's a good time to start tweaking our controller. First, we should get rid of all the boilerplate code we aren't using. Only the `new` and `create` methods should remain.

It's also probably a good time do describe some methods that sorcery *magically* provides for our controllers:
* `require_login` is useful as a before filter for controllers that require authentication
* `login(email, password, remember_me = false)`
* `auto_login(user)` performs the login operation without the need of any credentials
* `logout`
* `logged_in?` also available to views
* `current_user` also available to views
* `redirect_back_or_to` used when a user tries to access a page while logged out, is asked to login, and we want to return him back to the page he originally wanted.

In the `create` method, we will try to persist the input we receive, if the operation succeeds, then we use `auto_login` onto the newly created user and the we redirect him/her to the root of the website.

Another thing we need to make sure is that once the user is `logged_in?` then it can't access the registration form to obtain a new identity, at least not before he logs out

This is what the controller should looks like:

```ruby
class UsersController < ApplicationController
  before_action do
    if logged_in?
      # this can probably be improved with something more professional, but it
      # will do the job
      redirect_to root_path, notice: 'Unauthorized'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to root_path, notice: 'Your registration was successful, you have been logged in'
    else
      render :new
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :surname)
  end
end
```

Now let's try the registration form to see if it works! If everything is ok, you should be redirected to the root of the website and you should see the "Your registration was successful ..." message at the top of the web page.

Once we are registered, if we try to go back to the registration form, we should be redirected to the home page with the 'Unauthorized' message.

To perform a logout, for now, we have to clear the cookies.

### Login and logout

Now that we can register new users, we should allow them to login and logout. For this task, we will define a specific controller, `SessionsController`, that will take care of the operation.

Run the usual command to generate the boilerplate:
```sh
rails g scaffold session email:string password:string --migration false
```

Now configure the routes, like this:
```ruby
get 'login' => 'sessions#new'
post 'login' => 'sessions#create'
post 'logout' => 'sessions#destroy'
```

As usual, clear the views from broken code and dead links we don't need, so that they look like this:

`new.html.erb`

```
<h1>Login</h1>

<div class="mdl-cell mdl-cell--12-col">
  <p id="notice"><%= notice %></p>
</div>

<%= render 'form' %>
```

We have added a `div` into the template where a message, if the login fails, can be rendered

`_form.html.erb`

```
<%= form_for(@user, url: login_path) do |f| %>
  <div class="field">
    <%= f.label :email %><br>
    <%= f.text_field :email %>
  </div>
  <div class="field">
    <%= f.label :password %><br>
    <%= f.text_field :password %>
  </div>
  <div class="actions">
    <%= f.submit %>
  </div>
<% end %>
```

Now the complex part, the controller. This code is mainly copied from the sorcery wiki, even though it was adapted for our use case.

```ruby
class SessionsController < ApplicationController
  # GET /sessions/new
  def new
    @user = User.new
  end

  def create
    if login(session_params[:email], session_params[:password])
      redirect_back_or_to(root_url, notice: 'Login successful')
    else
      @user = User.new
      flash.now[:notice] = 'Wrong username or password'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: 'Logged out!')
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def session_params
    params.require(:user).permit(:email, :password)
  end
end
```

We proceed now to test the newly implemented functionality.

### Navigation

It would be nice to have a tangible proof about the fact that the code we wrote is working, and a feature we need anyway are some contextual links, "login", "register", "logout", at the top of our web pages.

The contextual navigation can be easily implemented using the `logged_in?` function.

Here is a fragment of the layout that we modified, to have the contextual navigation for both mobile and desktop browsers:

```erb
<header class="mdl-layout__header">
  <div class="mdl-layout__header-row">
    <!-- Title -->
    <span class="mdl-layout-title logo"><a href="/">Cittadini crescono</a></span>
    <!-- Add spacer, to align navigation to the right -->
    <div class="mdl-layout-spacer"></div>
    <!-- Navigation. We hide it in small screens. -->
    <nav class="mdl-navigation mdl-layout--large-screen-only">
      <% if logged_in? %>
        <%= link_to "Logout", logout_path, method: :post, class: "mdl-navigation__link" %>
      <% else %>
        <%= link_to "Register", register_path, class: "mdl-navigation__link" %>
        <%= link_to "Login", login_path, class: "mdl-navigation__link" %>
      <% end %>
    </nav>
  </div>
</header>
<div class="mdl-layout__drawer">
  <span class="mdl-layout-title">Cittadini crescono</span>
  <nav class="mdl-navigation">
    <% if logged_in? %>
      <%= link_to "Logout", logout_path, method: :post, class: "mdl-navigation__link" %>
    <% else %>
      <%= link_to "Register", register_path, class: "mdl-navigation__link" %>
      <%= link_to "Login", login_path, class: "mdl-navigation__link" %>
    <% end %>
  </nav>
</div>
```

A partial could be used to *dry* the code.

### Authorization

Now you can click on the "Login" link, enter your username and password, and get redirected to the home page with a nice flash message. Try the "Logout" link as well.

OK, that's nice, but our logged-out users can do anything a logged-in user can. We will fix this in the future using the `:require_login method`.
```ruby
before_action :require_login
```
