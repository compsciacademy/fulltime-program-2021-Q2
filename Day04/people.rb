
class Person
    attr_reader :name, :age
    def initialize(name, age)
        @name, @age = name, age
    end
end

# write to a file
def write(person)
    File.open('people', 'a') do |file|
        file.write("#{person.name}, #{person.age}\n")
    end
end

# read from a file
# returns a Person object
def read_all
    people = []
    File.open('people', 'r') do |file|
        file.each do |line|
            name = line.split(',')[0]
            age = line.split(',')[1]
            person = Person.new(name, age)
            people << person
        end
    end

    people
end

def test
    p1 = Person.new("Cathy", 19)
    p2 = Person.new("George", 27)

    write(p1)
    write(p2)
    people = read_all
    people.each do |person|
        puts person.name
        puts person.age
    end
    system('rm people')
end

test
