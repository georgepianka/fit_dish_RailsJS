class Substitution < ApplicationRecord
  belongs_to :recipe_ingredient
  belongs_to :user
  belongs_to :ingredient, optional:true

  validates :quantity, presence: true
  validates :ingredient, presence: true
  validates :description, presence: true
end
