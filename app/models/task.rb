class Task < ApplicationRecord
  attr_accessor :skip_titleize_name

  belongs_to :category, optional: true
  has_and_belongs_to_many :tags
  has_many :task_assignments, dependent: :destroy
  has_many :users, through: :task_assignments
  # t.string "name"
  # t.text "description"
  # t.integer "position"
  # t.boolean "completed"
  # t.datetime "created_at", null: false
  # t.datetime "updated_at", null: false
  # t.integer "category_id"
  validates_presence_of :name
  validates_length_of :name, maximum: 50
  validates_presence_of :position
  validates_numericality_of :position, greater_than: 0

  validate :description_has_no_prohibited_words

  before_validation :titleize_name, unless: :skip_titleize_name
  before_validation :set_default_position, if: Proc.new {|t| t.position.blank? || t.position < 1 }
  after_validation :log_validation
  before_create :log_create
  before_update :log_update
  after_save :log_save
  after_commit :cleaning_reminder, if: :too_many_records

  scope :complete, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
  scope :sorted, -> { order(:position)}
  scope :search, -> (kw) { where("LOWER(name) like ?", "%#{kw.downcase}%") }

  private

  def description_has_no_prohibited_words
    return unless description.present?
    prohibited_words = ['later', 'eventually', 'someday']
    prohibited_words.each do |word|
      if description.include?(word)
        errors.add(:description, "cannot contain prohibited word: #{word}")
      end
    end
  end
  def log_validation
    logger.debug("After validation: #{name}")
  end
  def titleize_name
    self.name = name.titleize
  end

  def set_default_position
    max = Task.maximum(:position) || 0
    self.position = max + 1
  end

  def log_create
    logger.debug("Task being created: #{name}")
  end

  def log_update
    logger.debug("Task being updated: #{name}")
  end

  def log_save
    # runs on both create & update
    logger.debug("Task was saved: #{name}")
  end

  def cleaning_reminder
    # This could be a placeholder for sending an email to an admin
    logger.debug("Remember to prune old tasks")
  end

  def too_many_records
    Task.count > 4
  end

end
