class AddQuantityToSubstitutions < ActiveRecord::Migration[5.2]
  def change
    add_column :substitutions, :quantity, :string
  end
end
