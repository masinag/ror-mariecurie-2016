
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

Let's import them in our application project.

Now open `/app/views/layouts/application.html.erb` and edit it as follows:
* Within the `<head>` tag let's add the link to the material icons we will use in our application.
~~~html
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
~~~

* Then substitute the `<body>` with the following code.
~~~html
<body>
  <!-- Always shows a header, even in smaller screens. -->
  <div class="mdl-layout mdl-js-layout mdl-layout--fixed-header mdl-layout--no-desktop-drawer-button mdl-color--grey-200">
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

Now, the title "CittadiniCrescono" changes appearance on mouse over. In order to fix it and keep it as it is, without transformation let's **remove** the following rules form the `app/assets/stylesheets/scaffolds.scss` file.
~~~css
a {
  color: #000;

  &:visited {
    color: #666;
  }

  &:hover {
    color: #fff;
    background-color: #000;
  }
}
~~~

And **add** the following in the `app/assets/stylesheets/application.css`:
~~~css
.logo {
  color: #fff;
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
  max-width: 1600px;
  margin: auto;
}
~~~

Now, let's take a look on cards! [https://getmdl.io/components/index.html#cards-section](https://getmdl.io/components/index.html#cards-section)

Now that we are ready, we can use cards to represent activities in the homepage! Let's use them.

But first, let's organize cards within a grid view. [https://getmdl.io/components/index.html#layout-section](https://getmdl.io/components/index.html#layout-section)

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
  <div class="mdl-cell mdl-cell--4-col mdl-card">
      <div class="mdl-card__title">
        <h2 class="mdl-card__title-text"><%= activity.title %></h2>
        <!-- Here you can add a menu if you want: see menu page in mdl -->
      </div>
      <div class="mdl-card__supporting-text">
        <%= activity.description %>
        <br>
        <%= activity.category %>
      </div>
      <div class="mdl-card__actions">
        <%= link_to 'Show', activity, :class => "mdl-button mdl-js-button mdl-button--raised mdl-button--colored" %>
      </div>
  </div>
  <% end %>
  <div class="mdl-cell mdl-cell--12-col">
    <%= link_to 'New Activity', new_activity_path %>
  </div>
</div>
~~~

Now, that we have a nice interface, we can add validations, and reason on how errors appear in the views.

~~~ruby
class Activity < ActiveRecord::Base
  validates :title, :description, :category, presence: true
  validates :title, uniqueness: true
end
~~~

Hence, try to change how the errors are displayed. In particular, you can edit all the activities views.
An example of how we can adjust the

Now, let's add the attribute `location` to Activities using the `AddXXXToYYY` form the command line.

~~~bash
rails generate migration AddLocationToActivities location:string
~~~

Let's add the location to all the views and in particular add a location for each activity in the `seeds.rb` file. You can do it as follows.

~~~ruby
10.times do |i|
  Activity.create!(
    title: "Activity ##{i}",
    description: "This activity needs ##{i} students. They will have to help people in order to do something very useful.",
    category: "elders",
    location: "Pergine Valsugana, TN"
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
