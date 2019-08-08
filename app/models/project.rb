class Project < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :bugs, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  validate :validate_user_type

  private

  def validate_user_type
    errors.add(:user_type, 'not valid to create a project') if creator.user_type && creator.user_type != 'manager'
  end
end
