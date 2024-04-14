class AddCategoryToRecipe < ActiveRecord::Migration[7.1]
  def change
    add_column(:recipes, :category_id, :integer)
    add_index(:recipes, :category_id)
  end
end
