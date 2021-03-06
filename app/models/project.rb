class Project < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :user_projects
  has_many :users, through: :user_projects
  has_many :bugs, dependent: :destroy

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  validate :validate_user_type

  after_destroy_commit :remove_destroyed_row

  private

  def validate_user_type
    errors.add(:user_type, 'not valid to create a project') if creator && !creator.manager?
  end

  def remove_destroyed_row
    ActionCable.server.broadcast 'project_channel', id: id
  end
end
