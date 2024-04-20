class ChangeDefaultQuantityUnitNullInIngredients < ActiveRecord::Migration[7.1]
  def change
    change_column :ingredients, :default_quantity_unit_id, :bigint, null: true
  end
end
