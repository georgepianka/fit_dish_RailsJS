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

  accepts_nested_attributes_for :recipe_ingredients, :reject_if => proc{|recipe_ingredient| recipe_ingredient[:quantity].blank? && recipe_ingredient[:ingredient_attributes][:name].blank?}

end
