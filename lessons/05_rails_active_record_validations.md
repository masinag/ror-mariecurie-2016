# Ruby on Rails Active Record

## Active Record Validations

Validations are used to ensure that only **valid** data are saved into our database.

The simplest validation that can be added to our model is the one that does not allow to store information with *nil* values for some attributes.

In fact, as we did in the last lesson, we can create a new article and store it with nil values as follows:

~~~ruby
a = Article.new
a.save
~~~

This produces the following:

~~~bash
# => #<Article id: 1, title: nil, body: nil, ... >
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
Error!!!!!!!!!!
~~~

Now, let's add more validations.

~~~ruby
class Article < ActiveRecord::Base
  validates :title, presence: true
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
