class AddDefaultQuantityUnitToIngredients < ActiveRecord::Migration[7.1]
  def change
    add_reference :ingredients, :default_quantity_unit, null: false, foreign_key: { to_table: :quantity_units }

  end
end
