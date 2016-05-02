
# The CittadiniCrescono Project

## Users Stories

* Come utente voglio poter vedere la lista delle attività di volontariato disponibili visualizzando per ciascuna di esse  titolo, descrizione e categoria.

* Come utente associato voglio poter creare un'attività inserendo titolo, descrizione e categoria e, una volta creata, voglio vederla nella lista delle attività.

## Activity

Let's start generating what is needed in order to manage activities. As we saw in past lessons, let's use the following command.

~~~bash
$ rails generate scaffold Activity title:string description:text category:string
~~~

In order to apply changes to our database, let's run the pending migration.

~~~bash
$ rake db:migrate
~~~

Now, what we want to have is an homepage in which users can see a list of all the activities stored in our database. Let's edit the `routes.rb` file by adding the following line.

~~~ruby
root 'activities#index'
~~~

Now, we might populate our database as we have done in the past lessons using the `rails console` command. However, a faster way to do it is to edit the `seeds.rb` file with the following ruby code.

~~~ruby
10.times do |i|
  Activity.create!(
    title: "Activity ##{i}",
    description: "This activity needs ##{i} students. They will have to help people in order to do something very useful.",
    category: "elders"
  )
end
~~~

Hence, in order to run this file you need to run the `rake db:seed` command.

## Introduction to Material Design Lite (MDL)

For the UI part, we use Material Design Lite (MDL). Please visit [https://getmdl.io](https://getmdl.io).

Download the pack and unzip it. We are actually interested in only the following two files:
* material.min.css
* material.min.js

Let's import them in our application project by adding the following lines:

~~~
//= require material.min
*= require material.min
~~~


Now open `/app/views/layouts/application.html.erb` and edit it as follows:
* Within the `<head>` tag let's add the link to the material icons we will use in our application.
~~~html
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
~~~

* Then substitute the `<body>` with the following code (Layouts -> Fixed Header in MDL).
~~~html
<body class="mdl-color--grey-200">
  <!-- Always shows a header, even in smaller screens. -->
  <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header mdl-layout--no-desktop-drawer-button">
    <header class="mdl-layout__header">
      <div class="mdl-layout__header-row">
        <!-- Title -->
        <span class="mdl-layout-title logo"><a href="/">CittadiniCrescono</a></span>
        <!-- Add spacer, to align navigation to the right -->
        <div class="mdl-layout-spacer"></div>
        <!-- Navigation. We hide it in small screens. -->
        <nav class="mdl-navigation mdl-layout--large-screen-only">
          <a class="mdl-navigation__link" href="">Link</a>
          <a class="mdl-navigation__link" href="">Link</a>
          <a class="mdl-navigation__link" href="">Link</a>
          <a class="mdl-navigation__link" href="">Link</a>
        </nav>
      </div>
    </header>
    <div class="mdl-layout__drawer">
      <span class="mdl-layout-title">CittadiniCrescono</span>
      <nav class="mdl-navigation">
        <a class="mdl-navigation__link" href="">Link</a>
        <a class="mdl-navigation__link" href="">Link</a>
        <a class="mdl-navigation__link" href="">Link</a>
        <a class="mdl-navigation__link" href="">Link</a>
      </nav>
    </div>
    <main class="mdl-layout__content">
      <div class="page-content">
        <%= yield %>
      </div>
    </main>
  </div>
</body>
~~~

Now, the title (or logo) "CittadiniCrescono" changes appearance on mouse over. In order to fix it and to keep it as it is, without transformation let's **delete** all the rules form the `app/assets/stylesheets/scaffolds.scss` file.
Then **edit** the `app/assets/stylesheets/activities.scss` file as follows.


~~~css

/* Per il logo */
.logo {
  color: #fff;
  text-transform: none;
  text-decoration: none;
}

.logo a,
.logo a:visited,
.logo a:hover {
    color: #fff;
    text-transform: none;
    text-decoration: none;
}

/* Per centrare */
.page-content {
  max-width: 1050px;
  margin: auto;
}
~~~

Now, let's take a look on cards! [https://getmdl.io/components/index.html#cards-section](https://getmdl.io/components/index.html#cards-section)

Now that we are ready, we can use cards to represent activities in the homepage! Let's use them.

But first, let's organize cards within a grid view [https://getmdl.io/components/index.html#layout-section](https://getmdl.io/components/index.html#layout-section).

First of all, let's edit the `app/views/activities/index.html.erb` view.

~~~html
<div class="mdl-grid">
  <div class="mdl-cell mdl-cell--12-col">
    <p id="notice"><%= notice %></p>
  </div>
  <div class="mdl-cell mdl-cell--12-col">
    <h1>Listing Activities</h1>
  </div>
  <% @activities.each do |activity| %>
  <div class="mdl-cell mdl-cell--4-col-desktop mdl-cell--12-col-tablet mdl-cell--12-col-phone mdl-card">
      <div class="mdl-card__title">
        <h2 class="mdl-card__title-text"><%= activity.title %></h2>
      </div>
      <div class="mdl-card__supporting-text">
        <%= activity.description %>
        <br>
        <%= activity.category %>
      </div>
      <div class="mdl-card__actions">
        <%= link_to 'Show', activity, :class => "mdl-button mdl-js-button mdl-button--raised mdl-button--colored" %>
        <%= link_to 'Edit', edit_activity_path(activity), :class => "mdl-button mdl-js-button mdl-button--primary" %>
        <%= link_to 'Destroy', activity, method: :delete, data: { confirm: 'Are you sure?' }, :class => "mdl-button mdl-js-button mdl-button--accent" %>
      </div>
  </div>
  <% end %>
</div>
~~~

Now, we want to change the style of the `link_to` component created by Rails. We would like to make it a rounded button as the buttons we saw as components in mdl. In order to to that, you can write the following:

~~~html
<%= link_to new_activity_path do %>
  <button class="mdl-button mdl-js-button mdl-button--fab mdl-button--colored">
    <i class="material-icons">add</i>
  </button>
<% end %>
~~~

In order to make it **VERY MATERIAL** :) let's add the following class to the `link_to` component by writing the following:

~~~html
<%= link_to new_activity_path, :class => "bottom-right-fixed" do %>
~~~

Add to the `activities.scss` file the following rule
~~~css
.bottom-right-fixed {
  position: fixed;
  right: 30px;
  bottom: 30px;
  z-index: 9;
}
~~~
Here you are, your **material button** is there!

Congratulations!! Your first material design homepage is ready and it should look as follows!

![You first material design homepage](https://raw.githubusercontent.com/ict4g/ror-mariecurie-2016/master/project/specs/img/05.jpg "homepage")

In the same way you can edit all the other views. For example let's modify the `_form.html.erb` file from this:

~~~html
<div class="field">
  <%= f.label :title %><br>
  <%= f.text_field :title %>
</div>
<div class="field">
  <%= f.label :description %><br>
  <%= f.text_area :description %>
</div>
<div class="field">
  <%= f.label :category %><br>
  <%= f.text_field :category %>
</div>
<div class="actions">
  <%= f.submit %>
</div>
~~~

To this:

~~~html
<div class="mdl-textfield mdl-js-textfield">
  <%= f.text_field :title, :class => "mdl-textfield__input", :id => "title" %>
  <%= f.label :title, :class => "mdl-textfield__label", :for => "title"%>
</div>
<br/>
<div class="mdl-textfield mdl-js-textfield">
  <%= f.text_area :description, :class => "mdl-textfield__input", :id => "description" %>
  <%= f.label :description, :class => "mdl-textfield__label", :for => "description"%>
</div>
<br/>
<div class="mdl-textfield mdl-js-textfield">
  <%= f.text_field :category, :class => "mdl-textfield__input", :id => "category" %>
  <%= f.label :category, :class => "mdl-textfield__label", :for => "category"%>
</div>
<br/>
<div class="actions">
  <%= f.submit :class => "mdl-button mdl-js-button mdl-button--raised mdl-button--accent" %>
</div>
~~~

Now, that we have a nice interface, we can add validations, and reason on how errors appear in the views.

~~~ruby
class Activity < ActiveRecord::Base
  validates :title, :description, :category, presence: true
  validates :title, uniqueness: true # Maybe-Maybe not
end
~~~

Hence, try to change how the errors are displayed. In particular, you can edit all the activities views.
An example of how we can adjust the

Now, let's add the attribute `address` to Activities using the `AddXXXToYYY` form the command line.

~~~bash
rails generate migration AddAddressToActivities address:string
~~~

Let's add the address to all the views, validations and in particular add an address for each activity in the `seeds.rb` file. You can do it as follows.

~~~ruby
10.times do |i|
  Activity.create!(
    title: "Activity ##{i}",
    description: "This activity needs ##{i} students. They will have to help people in order to do something very useful.",
    category: "elders",
    address: "Pergine Valsugana, TN"
  )
end
~~~

## The Geocoder gem

Add the gem `geocoder` in your `Gemfile`. For more info, please visit [https://github.com/alexreisner/geocoder](https://github.com/alexreisner/geocoder).

~~~bash
rails generate migration AddLatitudeAndLongitudeToActivities latitude:float longitude:float
~~~

And then, run the migration as usual.

~~~bash
rake db:migrate
~~~

Add validations for address!

~~~ruby
validate :valid_address, if: -> { address.present? and address_changed? }
​
private

def valid_address
  errors.add(:address, s_("ValidationError|doesn't seem to be a valid address")) if Geocoder.search(address).empty?  
end
~~~

## The Faker gem

Add the gem `faker` in your `Gemfile`. For more info, please visit [https://github.com/stympy/faker](https://github.com/stympy/faker).

~~~ruby
group :development, :test do
  gem 'faker'
end
~~~

Then run `bundle install`.

Finally, you are able to use the faker gem inside the `seeds.rb` file as follows.

~~~ruby
require 'faker'

20.times do |i|
  Activity.create!(
    title: Faker::Hipster.sentence(3),
    description: Faker::Hipster.paragraph(3),
    category: "elders",
    location: "Pergine Valsugana, TN"
  )
end
~~~
