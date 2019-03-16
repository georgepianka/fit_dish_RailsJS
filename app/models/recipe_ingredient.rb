class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  validates :quantity, presence: true

  def ingredient_attributes=(ingredient_attributes)
    ingredient_attributes.values.each do |val|
      if attr.present?
        self.ingredient = Ingredient.where(name: val).first_or_create
      end
    end
  end

end
