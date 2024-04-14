class Meal < ApplicationRecord
  belongs_to :meal_plan, inverse_of: :meals
  belongs_to :recipe
  def to_s
    "#{I18n.localize(date, format: '%a')} - #{I18n.localize(date, format: '%-m/%-d/%y')} "
  end
end
