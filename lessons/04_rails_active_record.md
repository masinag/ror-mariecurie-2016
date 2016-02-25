# Ruby on Rails Active Record

## Active Record Basics

Active Record is the M (the model) in MVC. It is the layer of the system responsible for representing business data and logic. Active Record facilitates the creation and use of business objects whose data requires persistent storage to a database.

### Object Relational Mapping

Using ORM, the properties and relationships of the objects in an application can be easily stored and retrieved from a database without writing SQL statements directly and with less overall database access code.

Active Record gives us several mechanisms, the most important being the ability to:
- Represent models and their data.
- Represent associations between these models.
- Represent inheritance hierarchies through related models.
- Validate models before they get persisted to the database.
- Perform database operations in an object-oriented fashion.

### Convention Over Configuration

With ORM, and in particular with Convention Over Configuration, you need to follow some conventions. So, for a class Book, you should have a database table called books. In fact:
- Database Table - Plural with underscores separating words (e.g., book_clubs).
- Model Class - Singular with the first letter of each word capitalized (e.g., BookClub).

There are conventions also for some fields in database tables:
- Primary keys - By default, Active Record will use an integer column named `id` as the table's primary key. When using `Active Record Migrations` to create your tables, this column will be automatically created.
- Foreign keys - These fields should be named following the pattern singularized_table_name_id (e.g., `item_id`, `order_id`). These are the fields that Active Record will look for when you create associations between your models.

There are also some optional column names that will add additional features to Active Record instances:
- created_at - Automatically gets set to the current date and time when the record is first created.
- updated_at - Automatically gets set to the current date and time whenever the record is updated.

## Active Record Query Interface
### CRUD: Create, Read, Update, Delete

Let's us use the `rails generate scaffold` command in order to manage a new resource called `Article` as follows:

~~~bash
$ rails generate scaffold Article title:string body:string category:string
$ rake db:migrate
~~~

Look at the routes, look at the model, look at the controller.
Now, let's us play a bit with Active Record!

~~~bash
$ rails console
~~~

### Create

Let's create some articles:

~~~ruby
a = Article.new
puts a
a.save
~~~

Add another one:

~~~ruby
b = Article.new(title: "A beautiful title", body: "lorem ipsum dolor sit amet...")
puts b
b.save
~~~

Rather than using the methods `new` and `save` you can use `create` as follows:

~~~ruby
c = Article.create(title: "A beautiful title", body: "lorem ipsum dolor sit amet...")
puts c
~~~

### Read

~~~ruby
articles = Article.all
one = Client.find(1)
first = Article.first
last = Article.last
found = Article.find_by(title: 'A beautiful title')
~~~

### Update

~~~ruby
first = Article.first
first.title = "First article"
first.save
~~~

but you can also write it down in the following way:
~~~ruby
first = Article.first
first.update(title: "First article")
~~~

### Delete

~~~ruby
first = Article.first
first.destroy
~~~

You can also delete all the articles as follows:

~~~ruby
Article.destroy_all
~~~

## Validations, validations validations

~~~ruby
class Article < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :category, inclusion: { in: %w(sport technology nature), message: "%{value} is not a valid category" }
  validate :body_cannot_contains_stupid_words
end

def body_cannot_contains_stupid_words
  if body.include? "stupid" then
    errors.add(:body, "can't contains the word stupid")
  end
end
~~~

Now, you can check validity of an article using methods `valid?` and `invalid?`.
~~~ruby
a = Article.new
puts a.valid? # False
puts a.invalid? # True
b = Article.new(title: "Another beautiful title")
puts b.valid? # True
~~~

Note: the `create`, `save` and `update` methods have also a bang version: `create!`, `save!` and `update!`. The difference is that methods with bang raise an exception if the record is invalid. The non-bang versions don't, save and update return false, create just returns the object.

When a record is *invalid* an error message is written in the `.errors.messages` array.
~~~ruby
a = Article.new
puts a.errors.messages
~~~

You might want to inspect the errors array by looking each attribute.
~~~ruby
a = Article.new
puts a.errors[:title]
puts a.errors[:title].any?
~~~

Now, you might want to add your own check, so let's define a validation method for Article.

~~~ruby
class Article < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :category, inclusion: { in: %w(sport technology nature), message: "%{value} is not a valid category" }
  validate :body_cannot_contains_stupid_words
end

def body_cannot_contains_stupid_words
  if body.include? "stupid" then
    errors.add(:body, "can't contains the word stupid")
  end
end
~~~
