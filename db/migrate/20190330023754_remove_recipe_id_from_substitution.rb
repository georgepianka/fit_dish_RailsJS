class RemoveRecipeIdFromSubstitution < ActiveRecord::Migration[5.2]
  def change
    remove_column :substitutions, :recipe_id, :integer
  end
end
