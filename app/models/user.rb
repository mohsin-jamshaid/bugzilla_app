class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name,presence:true
  # ,format:{with:/\A[a-zA-Z]+\z/}      
  enum user_type: [:manager, :developer, :qa]
  has_many :user_projects
  has_many :projects, through: :user_projects
  has_many :created_projects,class_name:"Project",foreign_key: "creator_id" 
end
