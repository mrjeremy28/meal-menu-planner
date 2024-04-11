class AddNumeratorDenominatorToRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    add_column :recipe_ingredients, :quantity_numerator, :integer
    add_column :recipe_ingredients, :quantity_denominator, :integer
  end
end
