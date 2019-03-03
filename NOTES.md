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
