
class User
  attr_accessor :name, :email
  def initialize(name, email)
    @name, @email = name, email
  end

  def save
    # save the current user
  end

  def self.find_by_email(email)
    # return a single user based on email address.
  end

  def self.all
    # return a list of all users
  end
end
