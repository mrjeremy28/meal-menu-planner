class ChangeQuantityFieldTypeInRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    reversible do |direction|
      change_table :recipe_ingredients do |t|
        direction.up   { t.change :quantity, :string }
        direction.down { t.change :quantity, :float }
      end
    end
  end
end
