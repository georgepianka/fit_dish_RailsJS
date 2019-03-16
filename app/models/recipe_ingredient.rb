class RecipeIngredient < ApplicationRecord
  belongs_to :recipe, optional:true
  belongs_to :ingredient, optional:true

  validates :quantity, presence: true

  def ingredient_attributes=(ingredient_attributes)
    ingredient_attributes.values.each do |val|
      if attr.present?
        self.ingredient = Ingredient.where(name: val).first_or_create
      end
    end
  end

end