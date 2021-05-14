class Worker
    attr_reader :name, :email, :id
    attr_accessor :is_employee
    @@LAST_ID=0

    def initialize(name, is_employee=true, email=nil)
        @id, @name, @is_employee, @email = get_id, name, is_employee, "#{name}-#{id}@example.com"
    end

    def get_id
        @@LAST_ID += 1
    end

    def to_s
        "id: #{@id}, name: #{@name}, email: #{@email}, employee: #{@is_employee}"
    end
end


c = Worker.new('drew', false)
e = Worker.new('christian')

puts c
puts e
