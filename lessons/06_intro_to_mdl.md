
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
50.times do |i|
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
    <main class="mdl-layout__content mdl-color--grey-200">
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
  <!-- The title occupies an entire row -->
  <div class="mdl-cell mdl-cell--12-col">
    <h1>Listing Activities</h1>
  </div>
  <!-- Here you can start with the loop -->
  <% @activities.each do |activity| %>
  <!-- mdl-card class is at the same level of mdl-cell -->
  <div class="mdl-cell mdl-cell--4-col mdl-card">
    <div class="mdl-card__title">
      <h2 class="mdl-card__title-text"><%= activity.title %></h2>
      <!-- Here you can add a menu if you want: see menu page in mdl -->
    </div>
    <div class="mdl-card__supporting-text">
      <%= activity.description %>
      <br/>
      <%= activity.category %>
    </div>
    <div class="mdl-card__actions">
    <%= link_to 'Show', activity, :class => "mdl-button mdl-js-button mdl-button--raised mdl-button--colored" %>
    </div>
  </div>
  <% end %>
</div>
~~~
