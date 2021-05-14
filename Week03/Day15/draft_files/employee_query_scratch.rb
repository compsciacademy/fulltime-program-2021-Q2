

# here's what's on my plate:
# here's what I understand the problem to be
#
# here's what inputs I am giving
# here's what outputs I am expecting
#
# here's my plan for solving this*
#



query = QueryParser.parse_query_string(query_string)

case query[:record_type]
when "employee" || "employees"
    if ["is", "equals", "is equal to", "are equal to"].include? query[:evaluator]
        Employee.find_by(query[:attribute], query[:value])
    end
when "contractor" || "contractors"
    Contractor.find_by(query[:attribute], query[:value])
when "project" || "projects"
    Project.find_by(query[:attribute], query[:value])
else
    "Unable to process query: #{query}"
end


class Employee
    #...
    def find_by(attribute, value)
        Employee.send("find_by_#{attribute}", value)
    end

    # QUERY E-MAIL
    def self.find_by_email(email)
        result = []
        employees = all
        employees.each do |e|
          if e.email == email
           result << "Employee name: #{e.name}\t\tE-mail: #{e.email}"
          else
            nil
          end
        end
        result
      end

    # ...
end
