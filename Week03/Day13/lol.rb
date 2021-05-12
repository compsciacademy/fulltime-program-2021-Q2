# def add_3(number_list)
#     return_array = []
#     number_list.each do |number|
#         return_array << number + 3
#     end
#     return_array
# end

def increment_each(number_list, num=1)
    number_list.map { |number| number + num }
end

puts increment_each([1, 2, 3, 4, 5], 27)












# class Greeting
#     def initialize(greeting)
#         @greeting = greeting
#     end

#     def self.greet
#         "Greetings!"
#     end

#     def greet
#         @greeting
#     end
# end

# puts Greeting.greet

# g = Greeting.new("I am an instance vaiable!")

# puts g.greet

# class Employee
#     def self.method
#     end
# end

# Employee.method



# # @employee = Employee.find(id)
# # @employee.set_wage(25.35)
# # @employee.save

# # @employee = Employee.find(id)
# # @employee.email = new_email
# # @employee.save


# Employee.get_me_an_employee_instance

# employee