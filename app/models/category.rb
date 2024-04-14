class Category < ApplicationRecord
  has_many :tasks, dependent: :nullify
  has_many :recipes, dependent: :nullify

  validates_length_of :name, within: 2..50

  scope :sorted, -> { order(:name)}

end
