class User < ApplicationRecord
  acts_as_authentic

  validates :email, uniqueness: true, length: { maximum: 100 }
  validates :login, uniqueness: true
  validates :password, length: { minimum: 8 }
  validates :password_confirmation, length: { minimum: 8 }
end