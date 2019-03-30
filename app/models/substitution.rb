class Substitution < ApplicationRecord
  belongs_to :recipe_ingredient, optional:true
  belongs_to :user
  belongs_to :ingredient, optional:true

  validates :quantity, presence: true
  validates :ingredient, presence: true
  validates :description, presence: true



  def ingredient_attributes=(ingredient_attributes)
    ingredient_attributes.values.each do |val|
      if val.present?
        self.ingredient = Ingredient.where(name: val).first_or_create
      end
    end
  end
end
