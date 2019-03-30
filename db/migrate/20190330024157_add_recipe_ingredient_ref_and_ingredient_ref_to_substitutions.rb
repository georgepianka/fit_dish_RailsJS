class AddRecipeIngredientRefAndIngredientRefToSubstitutions < ActiveRecord::Migration[5.2]
  def change
    add_reference :substitutions, :recipe_ingredient, foreign_key: true
    add_reference :substitutions, :ingredient, foreign_key: true
  end
end
