class Employee
    attr_reader :name, :email, :wage
    def initialize(name, email, wage)
        @name, @email = name, email, wage
    end
end
