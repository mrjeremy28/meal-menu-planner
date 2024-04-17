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
    quantity_label = quantity_numerator / quantity_denominator  > 1 ? quantity_unit.name.pluralize : quantity_unit.name
    [quantity, quantity_label, ingredient.name].join(' ')
    # [quantity, quantity_unit.name, ingredient.name, ].join(' ')
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

  def mixed_fraction_to_rational(mixed_fraction)
    whole, fraction = mixed_fraction.split(' ')
    whole ||= '0'
    numerator, denominator = fraction.split('/').map(&:to_i)
    Rational(whole.to_i * denominator + numerator, denominator)
  end

  def parse_quantity_string
    return if quantity.blank?

    # Regular expression to match space (e.g., 2 1/2)
    space_regex = /\s/

    if space_regex.match?(quantity) then
      ration_value = mixed_fraction_to_rational(quantity)
    else
      ration_value = Rational(quantity)
    end

    # Update quantity numerator and denominator
    self.quantity = ration_value.to_simplified_s
    self.quantity_numerator = ration_value.numerator
    self.quantity_denominator = ration_value.denominator

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
