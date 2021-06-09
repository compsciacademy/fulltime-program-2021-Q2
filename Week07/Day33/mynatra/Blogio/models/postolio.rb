class Postolio
  @@Postolios = []
  @@count = 0
  attr_accessor :title
  attr_accessor :body


  def save
    if self.id.nil?
      self.id = new_id
      @@Postolios.push(self)
    else
      self.id = self.id.to_i
      @@Postolios.each_with_index do |postolio, index|
        if self.id == postolio.id
          @@Postolios[index] = self
        end
      end
    end
  end

  def delete
    @@Postolios.each_with_index do |postolio, index|
      if postolio.id == self.id
        @@Postolios.delete_at index
      end
    end
  end

  def self.find(id)
    @@Postolios.each do |postolio|
      return postolio if postolio.id == id
    end
  end

  def self.all
    @@Postolios
  end

  private

  def new_id
    @@count += 1
  end
end
