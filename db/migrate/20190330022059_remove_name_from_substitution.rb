class RemoveNameFromSubstitution < ActiveRecord::Migration[5.2]
  def change
    remove_column :substitutions, :name, :string
  end
end
