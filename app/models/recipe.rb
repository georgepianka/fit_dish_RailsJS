class Recipe < ApplicationRecord
  belongs_to :user
  has_many :dishes
  has_many :likes, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy
  has_many :substitutions
  has_many :ingredients, through: :recipe_ingredients
  has_many :users, through: :dishes
  has_many :users_who_like, through: :likes, source: :user

  validates :name, presence: true
  validates :description, presence: true
  validates :instructions, presence: true

  validates :recipe_ingredients, presence: true

  accepts_nested_attributes_for :recipe_ingredients, :allow_destroy => true, :reject_if => proc{|recipe_ingredient| recipe_ingredient[:quantity].blank? && recipe_ingredient[:ingredient_attributes][:name].blank?}

  scope :recent, -> { order( created_at: :desc) }
  scope :alphabetical, -> { order( name: :asc) }
  scope :your_recipes, -> (user) { where(user_id: user) }
  scope :popular, -> { left_joins(:likes).group(:id).order(Arel.sql('COUNT(likes.id) DESC')) }

  def self.search_by_name(name)
    where('name ILIKE ?', "%#{name}%")
  end

  def self.search_by_ingredient(ingredient_name)
    joins(recipe_ingredients: :ingredient).where('ingredients.name ILIKE ?', "%#{ingredient_name}%").uniq
  end


end
