# Ruby on Rails Active Record

## Active Record Validations

Validations are used to ensure that only **valid** data are saved into our database.

The simplest validation that can be added to our model is the one that does not allow to store information with *nil* values for some attributes.

In fact, as we did in the last lesson, we can create a new article and store it with nil values as follows:

~~~ruby
a = Article.new
~~~

This produces the following:

~~~bash
=> #<Article id: nil, title: nil, body: nil, category: nil, created_at: nil, updated_at: nil>
~~~

Once we save it..

~~~bash
a.save
a
~~~

..we get the following result:

~~~bash
 => #<Article id: 1, title: nil, body: nil, category: nil, created_at: "2016-03-01 10:27:08", updated_at: "2016-03-01 10:27:08">
 ~~~

However, hopeful you want to store articles only if they have at least both a title and a body. This can be done in the following way.

~~~ruby
class Article < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
end
~~~

Now, if we re-try to create a new article and store it with neither a title nor a body this should not be valid. Hence, it should no stored in the database. In fact:

~~~ruby
a = Article.new
a.save
~~~

produces the following error:

~~~bash
(0.2ms)  begin transaction
(0.2ms)  rollback transaction
=> false
~~~

Note: the `create`, `save` and `update` methods have also a bang version: `create!`, `save!` and `update!`. The difference is that methods with bang raise an exception if the record is invalid. The non-bang versions don't, save and update return false, create just returns the object.

Now, let's add more validations.

~~~ruby
class Article < ActiveRecord::Base
  validates :title, :body, :category, presence: true
  validates :title, uniqueness: true
  validates :category, inclusion: { in: %w(sport technology nature), message: "%{value} is not a valid category" }
end
~~~

Once the Article model class is updated, validity of an article can be checked using methods `valid?` and `invalid?`.

~~~ruby
a = Article.new
puts a.valid? # False
puts a.invalid? # True
b = Article.new(title: "Another beautiful title")
puts b.valid? # False
c = Article.new(title: "Another beautiful title", body: "A beautiful body", category: "sport")
puts b.valid? # True
~~~

When a record is *invalid* an error message is written in the `.errors.messages` array.

~~~ruby
a = Article.new
puts a.errors
puts a.errors.messages
puts a.errors.full_messages # Usually used in views
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

  validates :title, :body, :category, presence: true
  validates :title, uniqueness: true
  validates :category, inclusion: { in: %w(sport technology nature), message: "%{value} is not a valid category" }

  validate :body_cannot_contains_stupid_words

  def body_cannot_contains_stupid_words
    if not body.nil? and body.include? "stupid" then
      errors.add(:body, "can't contains the word stupid")
    end
  end

end
~~~

## Active Record Migrations

Migrations are a feature of Active Record that allows you to evolve your database schema over time without writing schema modifications in pure SQL.

A schema starts off with nothing in it, and each migration modifies it to add or remove tables, columns, or entries.

Migrations are stored as files in the `db/migrate` directory, one for each migration class. The name of the file is of the form `YYYYMMDDHHMMSS_create_articles.rb`, that is to say a UTC timestamp identifying the migration followed by an underscore followed by the name of the migration.

Rails gives you some shortcuts in order to automatically generate migrations. Let's try to generate an empty one.

~~~bash
rails generate migration myfirstmigration
~~~

The above command will generate a file named `db/migrate/20160301140734_myfirstmigration.rb` which will looks like the following:

~~~ruby
class Myfirstmigration < ActiveRecord::Migration
  def change
  end
end
~~~

Now, let's change a bit the articles table by adding a new column as follows.

~~~ruby
class Myfirstmigration < ActiveRecord::Migration
  def change
    add_column :articles, :published, :boolean
  end
end
~~~

In order to apply these changes to the database we need to run the `rake db:migrate`command.

In addition, Rails is smarter than that, and it allows you to automatically generate the same migration in one line (using the `AddXXXToYYY`or `RemoveXXXFromYYY`format form the command line).

~~~bash
rails generate migration AddWordCountToArticles word_count:integer
~~~

Will generate the file `db/migrate/20160301142100_add_word_count_to_articles.rb` which will look like follows:

~~~ruby
class AddWordCountToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :word_count, :integer
  end
end
~~~

The change method is the primary way of writing migrations. It works for the majority of cases, where Active Record knows how to reverse the migration automatically. Currently, the change method supports only these migration definitions:

- add_column
- add_index
- add_reference
- add_timestamps
- add_foreign_key
- create_table
- create_join_table
- drop_table (must supply a block)
- drop_join_table (must supply a block)
- remove_timestamps
- rename_column
- rename_index
- remove_reference
- rename_table

Now, you might wonder how you can automatically store some resources in the development database. In order to do that, write down in your `db/seed.rb` file some Ruby code in order to create 200 Articles.

~~~ruby
200.times do |i|
  Article.create(
    title: "Article ##{i}",
    description: "An article with a beautiful body. This is the article ##{i}.",
    category: "sport"
  )
end
~~~

In order to run this file you need to run the `rake db:seed` command.

The `rake db:setup` task will create the database, load the schema and initialize it with the seed data.

The `rake db:reset` task will drop the database and set it up again. This is functionally equivalent to `rake db:drop` and `rake db:setup`.
