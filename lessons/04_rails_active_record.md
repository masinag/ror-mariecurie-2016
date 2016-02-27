# Ruby on Rails Active Record

## Active Record Basics

Active Record is the M (the model) in MVC. It is the layer of the system responsible for representing business data and logic. Active Record facilitates the creation and use of business objects whose data requires persistent storage to a database.

### Object Relational Mapping

Using ORM (Object Relational Mapping), the properties and relationships of the objects in an application can be easily stored and retrieved from a database without writing SQL statements directly and with less overall database access code.

Active Record gives us several mechanisms, the most important being the ability to:
- Represent models and their data.
- Represent associations between these models.
- Represent inheritance hierarchies through related models.
- Validate models before they get persisted to the database.
- Perform database operations in an object-oriented fashion.

### Convention Over Configuration

With Convention Over Configuration, you need to follow some conventions. So, for a class Book, you should have a database table called books. In fact:
- Database Table - Plural with underscores separating words (e.g., book_clubs).
- Model Class - Singular with the first letter of each word capitalized (e.g., BookClub).

There are conventions also for some fields in database tables:
- Primary keys: By default, Active Record will use an integer column named `id` as the table's primary key. When using Active Record Migrations to create your tables, this column will be **automatically** created.
- Foreign keys: These fields should be named following the pattern singularized_table_name_id (e.g., `item_id`, `order_id`). These are the fields that Active Record will look for when you create associations between your models.

There are also some optional column names that will add additional features to Active Record instances:

- `created_at`: Automatically gets set to the current date and time when the record is first created.
- `updated_at`: Automatically gets set to the current date and time whenever the record is updated.

## Active Record Query Interface
### CRUD: Create, Read, Update, Delete

Let's us use the `rails generate scaffold` command in order to manage a new resource called `Article` as follows:

~~~bash
$ rails generate scaffold Article title:string body:string category:string
~~~

And use the `rake db:migrate` command in order to create the table `articles` in our database (the development database).

~~~bash
$ rake db:migrate
~~~

At this point, a new resource is available. As a consequence, we must have routes to manage it. Let's us take a look on the routes (It may take some seconds...).

~~~bash
$ rake routes
~~~

A list of new rules should appear. All these routes in fact are resulted from a single line written in the routes.rb file.

~~~ruby
resources :articles
~~~

Now, let's us play a bit with **Active Record**! Please, open a Rails console.

~~~bash
$ rails console
~~~

### Create

Let's create a new article. The method `.new` as you might expect creates a new Article with nil values for all its attributes (id: nil, title: nil, body: nil, ...). The `.save` method allow us to save/store the created article in the database. Note that when you save an article in the database the id attribute is automatically incremented.

~~~ruby
a = Article.new
puts a
a.save
~~~

Let's add another one:

~~~ruby
b = Article.new(title: "A beautiful title", body: "lorem ipsum dolor sit amet...")
puts b
b.save
~~~

Rather than use both the methods `.new` and `.save` you can use `.create` to obtain the same result as follows:

~~~ruby
c = Article.create(title: "A beautiful title", body: "lorem ipsum dolor sit amet...")
puts c
~~~

Note that the invocation of `Article.create` returns the object just created.

### Read

There are a lot of default methods that allow you to read data from the database.

~~~ruby
articles = Article.all # Returns a list of all the articles stored in the database.
one = Client.find(1) # Returns the article for which its corresponding primary key (id) has value 1.
first = Article.first # Returns the first article stored.
last = Article.last # Returns the last article stored.
found = Article.find_by(title: 'A beautiful title') # Returns all the articles that have title equal to the specific value.
~~~

### Update

You can edit or update an existing article as follows:

~~~ruby
first = Article.first # Gets the first article
first.title = "First article" # Changes its title
first.save # Stores it
~~~

However, you can also write it down in the following way:

~~~ruby
first = Article.first # Gets the first article
first.update(title: "First article") # Update its attribute
~~~

### Delete

In order to delete or remove an article form the database, let's use the `.destroy` method.

~~~ruby
first = Article.first
first.destroy
~~~

You can also delete all the articles as follows:

~~~ruby
Article.destroy_all
~~~
