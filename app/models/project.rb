class Project < ApplicationRecord
  validates :title, presence: true
  belongs_to :creator, -> { where(user_type: 'manager') }, class_name: 'User'
  
  has_many :user_projects
  has_many :users, through: :user_projects
  
  before_create :validate_user_type

  def validate_user_type
    self.creator.user_type != 'manager' ? false : true
  end
end
