class Bug < ApplicationRecord
  include StateMachine::Bug

  include ActiveStorage::Image

  has_one_attached :image

  belongs_to :project
  belongs_to :assign_to, class_name: 'User', optional: true
  belongs_to :creator, class_name: 'User'

  validates :title, presence: true
  validates_uniqueness_of :title, scope: :project_id
  validates :deadline, presence: true
  validate :deadline_date_cannot_be_in_the_past
  validates :bug_type, presence: true, inclusion: { in: %w[feature bug] }
  validate :check_assign_to_value
  validate :check_creator_type
  validate :correct_image_type

  private

  def deadline_date_cannot_be_in_the_past
    errors.add(:deadline, "can't be in the past") if deadline.present? && deadline < Date.today
  end

  def check_assign_to_value
    errors.add(assign_to_id: "Should be a developer's id") if assign_to && !assign_to.developer?
  end

  def check_creator_type
    errors.add(creator_id: "Should be a qa's id") if creator_id.present? && !creator.qa?
  end
end
