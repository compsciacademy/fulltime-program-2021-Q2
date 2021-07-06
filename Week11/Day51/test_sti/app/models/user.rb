class User < ApplicationRecord
  validates :email, presence: true
  has_many :comments, as: :commentable
  has_many :discussions
end
