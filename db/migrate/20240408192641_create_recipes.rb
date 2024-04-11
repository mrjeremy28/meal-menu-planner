class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :servings
      t.text :instructions

      t.timestamps
    end
  end
end
