class RecipeIngredient < ApplicationRecord
  before_create :set_order
  before_validation :parse_quantity_string

  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :quantity_unit
  accepts_nested_attributes_for :ingredient


  validates_uniqueness_of :order, scope: :recipe_id

  scope :sorted, -> { order(:order) }


  def full_ingredient
    # quantity_ingredient = pluralize(quantity, quantity_unit.name)
    [quantity, quantity_unit.name, ingredient.name, ].join(' ')
  end

  def move_up
    swap_order_with(previous_ingredient)
  end

  def move_down
    swap_order_with(next_ingredient)
  end

  private

  def set_order
    if self.order == 0 then
      self.order = recipe.recipe_ingredients..maximum(:order).to_i + 1
    end
  end
  end

  def parse_quantity_string
    return if quantity.blank?

    # Regular expression to match fractions (e.g., 1/2)
    fraction_regex = /^(\d+)\/(\d+)$/

    if fraction_regex.match?(quantity)
      self.quantity_numerator, self.quantity_denominator = quantity.split('/').map(&:to_i)
    else
      self.quantity_numerator = quantity.to_i
      self.quantity_denominator = 1
    end
  end

  def previous_ingredient
    RecipeIngredient.where("\"order\" < ?", order).order(order: :desc).first
  end

  def next_ingredient
    RecipeIngredient.where("\"order\" > ?", order).order(:order).first
  end

  def swap_order_with(other_ingredient)
    return unless other_ingredient.present?

    tmp_order = other_ingredient.order
    other_ingredient.update(order: order)
    update(order: tmp_order)
  end

end
