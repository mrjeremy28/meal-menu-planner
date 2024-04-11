class Ingredient < ApplicationRecord
  has_one_attached :image
  belongs_to :default_quantity_unit, class_name: 'QuantityUnit'
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  has_many :quantity_units, through: :recipe_ingredients
end
