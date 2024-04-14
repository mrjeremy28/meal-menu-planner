class MealPlan < ApplicationRecord
  has_many :meals, -> { order(:date) }, inverse_of: :meal_plan, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true

  accepts_nested_attributes_for :meals

  def build_meals
    recipes = Recipe.all
    recipe_ids = recipes.pluck(:id)

    (start_date..end_date).each do |date|
      unused_recipe_ids = recipe_ids - meals.map(&:recipe_id)

      if unused_recipe_ids.empty?
        available_recipe_ids = recipe_ids
      else
        available_recipe_ids = unused_recipe_ids
      end

      meals.build(date: date, recipe_id: nil)
    end
  end

  def to_s
    "#{I18n.localize(start_date, format: '%a')} #{I18n.localize(start_date, format: '%-m/%-d/%y')} - #{I18n.localize(end_date, format: '%a')} #{I18n.localize(end_date, format: '%-m/%-d/%y')}"
  end

end
