class Ingredient < ApplicationRecord
  has_one_attached :image
  belongs_to :default_quantity_unit, class_name: 'QuantityUnit', optional: true
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients
  has_many :quantity_units, through: :recipe_ingredients

  validates_presence_of :name
  validates_length_of :name, maximum: 50

end
