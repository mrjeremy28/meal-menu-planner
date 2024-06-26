class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :task_assignments
  has_many :tasks, through: :task_assignments
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end


  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  # validates :first_name, presence: true, length: { maximum: 25 }
  # validates :last_name, presence: true, length: { maximum: 50 }
  # validates :email, presence: true,
  #                   length: { maximum: 100 },
	# 									uniqueness: true,
  #                   format: { with: EMAIL_REGEX },
  #                   confirmation: true

  # validates_acceptance_of :terms

  scope :sorted, -> { order(:last_name, :first_name) }

  def full_name
    [first_name, last_name].join(' ')
  end

  def last_name_first
    [last_name, first_name].join(', ')
  end

  def abbrev_name
    first_initial = first_name.chars.first + ". "
    [first_initial, last_name].join(' ')
  end
end
