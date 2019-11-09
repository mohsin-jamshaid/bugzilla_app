class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :password_has_required_content

  include ActiveStorage::Image

  before_create :set_default_avatar

  enum user_type: %i[manager developer qa]

  has_one_attached :avatar

  has_many :user_projects
  has_many :projects, through: :user_projects, dependent: :destroy
  has_many :created_projects, class_name: 'Project', foreign_key: 'creator_id', dependent: :destroy

  has_many :bugs, class_name: 'Bug', foreign_key: 'creator_id', dependent: :destroy
  has_many :assigned_bugs, class_name: 'Bug', foreign_key: 'assign_to_id', dependent: :nullify

  validates :name, presence: true
  validate :user_image_type

  def set_default_avatar
    avatar.attach(io: File.open("#{Rails.root}/app/assets/images/user.png"), filename: 'user.png', content_type: 'image/png') unless avatar.attached?
  end
end
