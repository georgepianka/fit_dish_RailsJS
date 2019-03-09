class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.text :instructions
      t.references :recipiable, polymorphic: true

      t.timestamps
    end
  end
end
