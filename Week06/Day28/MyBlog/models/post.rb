class Post
  @@Posts = []
  @@count = 0

  attr_accessor :title, :body, :id

  def save
    if self.id.nil?
      self.id = new_id
      @@Posts.push(self)
    else
      self.id = self.id.to_i
      @@Posts.each_with_index do |post, index|
        if self.id == post.id
          @@Posts[index] = self
          puts "So, you think you're here? I don't...."
        end
      end
    end
  end

  def delete
    @@Posts.each_with_index do |post, index|
      if post.id == self.id
        @@Posts.delete_at index
      end
    end
  end

  def self.find(id)
    @@Posts.each do |post|
      return post if post.id == id
    end
  end

  def self.all
    @@Posts
  end

  private

  def new_id
    @@count += 1
  end
end
