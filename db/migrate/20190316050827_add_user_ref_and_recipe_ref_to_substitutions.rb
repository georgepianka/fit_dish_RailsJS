class AddUserRefAndRecipeRefToSubstitutions < ActiveRecord::Migration[5.2]
  def change
    add_reference :substitutions, :user, foreign_key: true
    add_reference :substitutions, :recipe, foreign_key: true
  end
end
