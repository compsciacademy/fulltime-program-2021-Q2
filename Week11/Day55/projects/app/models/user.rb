class User < ApplicationRecord
  validates :email, presence: true
  has_many :comments, as: :commentable
  has_many :discussions
  has_many :projects
  devise :database_authenticatable, :registerable
end
