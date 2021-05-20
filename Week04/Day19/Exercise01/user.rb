module Encryption
  def self.encrypt(string)
    string.downcase
      .tr('aeiou', '_')
      .tr('bcdfgwhjklmnpvxyz', '*')
      .tr('qrst', '^')
      .tr('1234567890', '#')
  end
end

class User
  attr_reader :email, :encrypted_password

  def initialize(email, password)
    @email, @encrypted_password = email, Encryption.encrypt(password)
  end

  def save
    File.open('user', 'a') do |file|
      file.write("#{@email}, #{@encrypted_password}\n")
    end
  end

  def self.login(email, password)
    user = User.find_by(email)
    if user.encrypted_password == Encryption.encrypt(password)
      user
    else
      raise StandardError.new("Bad Password!")
    end
  end

  def self.find_by(email)
    File.open('user', 'r') do |file|
      file.each do |line|
        user_email, encrypted_password = line.split(', ')
        if user_email == email
          return User.new(user_email, encrypted_password.chomp)
        end
      end
    end
  end
end