class QuantityUnit < ApplicationRecord
  has_many :ingredients, foreign_key: :default_quantity_unit_id
  before_validation :singularize_name

  validates :name, presence: true,
                    length: { maximum: 100 },
										uniqueness: true,
                    confirmation: true

  def plural_name
    self.name.pluralize
  end

  private

  def singularize_name
    self.name = name.singularize if name.present?
  end

end
