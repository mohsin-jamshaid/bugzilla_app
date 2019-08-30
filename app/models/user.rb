class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :password_has_required_content

  include ActiveStorage::Image

  validates :name, presence: true
  validate :user_image_type

  enum user_type: %i[manager developer qa]

  has_one_attached :avatar

  has_many :user_projects
  has_many :projects, through: :user_projects, dependent: :destroy
  has_many :created_projects, class_name: 'Project', foreign_key: 'creator_id', dependent: :destroy

  has_many :bugs, class_name: 'Bug', foreign_key: 'creator_id', dependent: :destroy
  has_many :assigned_bugs, class_name: 'Bug', foreign_key: 'assign_to_id', dependent: :nullify
end
