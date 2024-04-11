class CreateQuantityUnits < ActiveRecord::Migration[7.1]
  def change
    create_table :quantity_units do |t|
      t.string :name

      t.timestamps
    end
  end
end
