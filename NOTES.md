Recipe
  # Belongs to both Dish and GroceryList... Polymorphic.
  has_many :recommended_substitutions
  belongs_to :recipiable, :polymorphic = true
  has_many :items



GroceryList
  has_many :recipes, :as => :recipiable
  belongs_to :user
  has_many :items, :through => :recipes

Dish
  has_one :recipe, :as => :recipiable
  has_many :items, :through => :recipe
  has_many :likes

User
  has_many :grocery_lists
  has_many :dishes
  has_many :likes, :through => :dishes

Items

Likes
  belongs_to :dish

RecommendedSubstitution

Let’s get concrete. Convert the LIKE query above to Arel and we get:

posts = Post.arel_table
Post.where(posts[:title].matches("%#{params[:title]}%"))
#=> SELECT `posts`.* FROM `posts` WHERE (`posts`.`title` LIKE '%foo%')
Here, we needed to first call Post.arel_table to get an instance of Arel::Table corresponding to the posts table for the model. We can then call posts[:title] to get an arel node (actually, an Arel::Attribute) for the title column.

We can then use this title node to build a query using the matches method, which corresponds to LIKE in MySQL.

This may not seem like such a big win, since anyway you could have written the query in raw SQL with less lines of code. But what if you wanted to re-use that snippet in combination with another condition?

You could certainly do this with a new inline SQL, but a more scalable way is to use Arel. For example:



FLASH: [:danger], [:info], [:primary]
