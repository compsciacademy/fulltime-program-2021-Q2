class User
  attr_accessor :email, :passsword

  def delete
    # TODO: remove user data from however
    # it is stored.
  end

  def self.all
    # TODO: look into serializing to different
    # file formats: YAML, JSON, etc.
    # and different DMBS solutions, sqlite, psql, mysql 
    (1..25).map do |num| 
      user = User.new
      user.email = "user#{num}@example.com"
      user
    end
  end
end
