class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { in: 5..22 }, format: { with: /\A([a-zA-Z]+|[a-zA-Z]+\s[a-zA-z]+)\z/ }

  enum user_type: %i[manager developer qa]

  has_many :user_projects
  has_many :projects, through: :user_projects, dependent: :destroy
  has_many :created_projects, class_name: 'Project', foreign_key: 'creator_id', dependent: :destroy
  has_many :bugs, class_name: 'Bug', foreign_key: 'creator_id', dependent: :destroy
  has_many :assigned_bugs, class_name: 'Bug', foreign_key: 'assign_to_id', dependent: :nullify
end
