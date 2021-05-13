# Support queries something like these:
#
# find employee where email_address equals drew@drew.com
# find employees where wage is greater than 25
# find employees where vacation_days are less than 10
# find employees where email_address is like *@company.com

# find employee where # return a single object
# find employees where # return a list of objects
#
# attribute: email_address, wage, vacation_days
# evaluator: equals, is greater than, are less than, is like
# value: drew@drew.com, 25, 10, *@company.com
#
# query: query_type record_type where attribute evaluator value
# query_type: find
# record_type: employee, employees

module QueryParser
    # parse_query_string takes in a query string and returns a
    # hash with query_type, record_type, attribute, value, and 
    # evaluator keys.
    #
    # query_strings must be in the following format:
    # <query_type> <record_type> where <attribute> <evaluator> <value>
    # e.g.
    # find employee where email is example@example.com
    def self.parse_query_string(query_string)
        left, right = query_string.split(" where ")
        query_type, record_type = left.split(' ')
        query = {
            :query_type =>  query_type,
            :record_type => record_type,
            :attribute => right.split(' ').first,
            :value => right.split(' ').last,
            :evaluator => right.split(' ')[1..-2].join(' ')
        }
    end
end

# sample query strings to use for testing
query_strings = [
    "find employee where email_address equals drew@drew.com",
    "find employees where wage is greater than 25",
    "find employees where vacation_days are less than 10",
    "find employees where email_address is like *@company.com",
    "find contractor where email_address is like *@company.com",
    "find project where start_date is like 10/30/2021",
    "find lolfaces where face is like *@yourFace.com"

]

def view_queries(query_strings)
    query_strings.each_with_index do |query_string, index|
        query = QueryParser.parse_query_string(query_string)
        puts "query number: #{index + 1}"
        puts "query type: #{query[:query_type]}"
        puts "record type: #{query[:record_type]}"
        puts "attribute: #{query[:attribute]}"
        puts "evaluator: #{query[:evaluator]}"
        puts "value: #{query[:value]}"
        puts "-------------------------"
    end
end

class RecordTypeNotFoundError < StandardError; end

query_strings.each do |query_string|
    query = QueryParser.parse_query_string(query_string)
    case query[:query_type]
    when "find"
        puts "Got your query! #{query.to_s}"
    when "add"
        puts "Got your query! #{query.to_s}"
    when "contractor"
        puts "Got your query! #{query.to_s}"
    when "project"
        puts "Got your query! #{query.to_s}"
    else
        raise RecordTypeNotFoundError.new("No Record Type: #{query[:record_type]}")
    end
end

def find_record_by_attribute(record_type, attribute, value)
    # how would having a method like this affect our above
    # switch case?
end

# find_record_by_attribute("employee", "email", "drew@drew.com")