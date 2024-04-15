class Recipe < ApplicationRecord
  attr_accessor :skip_titleize_name
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  belongs_to :category, optional: true
  has_many :meals, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy
  accepts_nested_attributes_for :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients, dependent: :destroy
  has_many :quantity_units, through: :recipe_ingredients, dependent: :destroy


  validates_presence_of :name
  validates_length_of :name, maximum: 50
  validates_presence_of :servings
  validates_numericality_of :servings, greater_than: 0

  before_validation :titleize_name, unless: :skip_titleize_name
  before_validation :set_default_servings, if: Proc.new {|t| t.servings.blank? || t.servings < 1 }

  # serialize :instructions, Array
  # scope :instructionList, -> { :instructions.split(/\n+/) }
  # scope :instructionList, -> { :instructions.split(/\n+/) }
  # alias_method 'instructionList', :instructions_array

  private

  def instructions_array
    self.instructions.split(/\n+/)
  end

  def titleize_name
    self.name = name.titleize
  end

  def set_default_servings
    self.servings = 4
  end

end
