
# The CittadiniCrescono Project

## Routes

Let's take a look on the `config/routes.rb` file. It should look as follows:

~~~ruby
Rails.application.routes.draw do

  resources :activities

  # You can have the root of your site routed with "root"
  root 'activities#index'

end
~~~

Now, let's open the terminal and write `rake routes`. If you prefer, you can visit 'http://localhost:3000/rails/info/routes' in the browser after running you application with `rails s`.

## Organizations

Now, let's scaffold a new resource named `Organizations` as follows.

~~~bash
rails generate scaffold Organization name:string description:text category:string url_logo:string
rake db:migrate
~~~

Now that we have the `Organizations` table in the database, we can generate some fake (we can use the Faker gem saw in lesson 06) data using the seed..

~~~ruby
Activity.destroy_all
Organization.destroy_all

10.times do |i|
  Activity.create!(
    title: "Activity ##{i}",
    description: "This activity needs ##{i} students. They will have to help people in order to do something very useful.",
    category: "elders"
  )
end

10.times do |i|
  Organization.create!(
    name: "Organization ##{i}",
    description: "This organization helps people.",
    category: "other"
  )
end
~~~

Let's run it!!! Remember: in order to run the `seed.rb` file you need to type `rake db:seed`.
Sometimes you might want to reset your database in order to reset from zero your primary key indexes. In order to do that you can type the following:

~~~bash
rake db:drop && rake db:create && rake db:migrate
rake db:seed
~~~

Again, take a look on the routes. What is changed? We should see the following two rules:

~~~ruby
Rails.application.routes.draw do

  resources :organizations
  resources :activities

  # You can have the root of your site routed with "root"
  root 'activities#index'

end
~~~

## Relationships

Well, now if you want you can manage activities and organizations independently. However we know that an activity exists only if there is an organization that published that activity. Hence, we need to consider the relationship between activities and organizations. What is the cardinality of that relationship? How we can represent it in Rails?

-> Brief intro with databases. <-

Please, write in the terminal the following command.

~~~bash
rails generate migration AddOrganizationToActivities organization:references
~~~

It will generate the following:

~~~ruby
class AddOrganizationsToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :association, :reference
  end
end
~~~

Now, let's run the migration and then take a look on `db/schema.rb` and see what is changed.

~~~bash
rake db:migrate
~~~

Now, let's edit the models!
Let's edit the `Activity` model as follows:

~~~ruby
class Activity < ActiveRecord::Base
  belongs_to :organization
  validates :title, :description, :category, presence: true
  validates :title, uniqueness: true
end
~~~

And the `Organization` model as follows:

~~~ruby
class Organization < ActiveRecord::Base
  has_many :activities
  validates :name, :description, :category, presence: true
  validates :name, uniqueness: true
end
~~~

Then play a bit with Active Record.

~~~ruby
Activity.first
Organization.first

Activity.first.organization # Thanks to belongs_to :organization
Organization.first.activities # Thanks to has_many :activities
~~~

We need to consider what are called **nested routes**.

~~~ruby
Rails.application.routes.draw do

  resources :associations do
    resources :activities
  end

  # You can have the root of your site routed with "root"
  root 'activities#index'

end
~~~

How do the routes appear right now?


~~~ruby
class ActivitiesController < ApplicationController

  # ...
  before_action :set_association

  # ...
  private
    def set_association
      @association = Organizations.find(params[:association_id]) unless params[:association_id].nil?
    end
end
~~~

Hence, rewrite the index method as follows.

~~~ruby
class ActivitiesController < ApplicationController

  # ...
  before_action :set_association

  # ...

  def index
    if @association.nil?
      @activities = Activity.all
    else
      @activities = @association.activities
    end
  end

  # ...
  private
    def set_association
      @association = Organizations.find(params[:association_id]) unless params[:association_id].nil?
    end
end
~~~

image_tag with the url_logo
