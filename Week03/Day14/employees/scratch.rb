require './query_parser'
require './employee'


# sample query strings to use for testing
query_strings = [
    "find employee where email_address equals drew@drew.com",
    "find employees where wage is greater than 25",
    "find employees where vacation_days are less than 10",
    "find employees where email_address is like *@company.com",
    "find contractor where email_address is like *@company.com",
    "find project where start_date is before 10/30/2021",
    "find project where start_date is after 10/30/2021",
    "find project where start_date is 10/30/2021",
    # "find project where city is 'los angeles'",
    "find lolfaces where face is like *@yourFace.com"
 

]

class RecordTypeNotFoundError < StandardError; end

def test_query_parser
    query_strings.each do |query_string|
        query = QueryParser.parse_query_string(query_string)
        case query[:query_type]
        when "employee"
            puts "Got your query! #{query.to_s}"
        when "employees"
            puts "Got your query! #{query.to_s}"
        when "contractor"
            puts "Got your query! #{query.to_s}"
        when "project"
            puts "Got your query! #{query.to_s}"
        else
            puts "Got your query! #{query.to_s}"

            # raise RecordTypeNotFoundError.new("No Record Type: #{query[:record_type]}")
        end
    end
end

def find_record_by_attribute(record_type, attribute, value)
    # how would having a method like this affect our above
    # switch case?
end

# find_record_by_attribute("employee", "email", "drew@drew.com")

# I want to be able to enter a query string, and have the results
# I expect returned!
#
# See `test_solution` for example
def solve_my_problem(query_string)
    [Employee.new("lolly", 'lol@awesomeco.com', 27)]
end

def test_solution
    employee1, employee2, employee3 = ["drew", "christian", "sarah"].map do |name|
        Employee.new(name, "#{name}@awesomeco.com", 22)
    end

    employee4 = Employee.new("lolly", 'lol@awesomeco.com', 27)

    employees = [employee1, employee2, employee3, employee4]

    desired_solution = "lolly"
    actual_solution = solve_my_problem("find employees where wage is greater than 24").first.name
    
    MyTest.test(actual_solution, desired_solution)
end

module MyTest
    def self.test(actual, expected)
        if actual == expected
            puts "Good job!"
        else
            puts "It doesn't quite work yet. Keep going!!!"
        end
    end
end

test_solution
