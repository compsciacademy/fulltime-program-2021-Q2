# Datastore is an interface between our application layer and
# our data layer.
#
#   All our data is being stored in files (or more specifically at the moment) in
#   one file.
#
#   However, that is not the concern of our application. This is merely the
#   concern of our datastore (or data layer). The communication interface between
#   our application and our datastore cares about objects. Specifically, at the
#   moment, we have user objects.
# require '../user'

class Datastore
    def self.list(items)
        rows = []
        File.open("./data/#{items}", 'r') do |file|
            file.each do |line|
                rows << line
            end
        end
        rows
    end

    def self.write(klass, item)
        filename = "#{klass.to_s.downcase}s"

        File.open("./data/#{filename}", 'a') do |file|
            file.write("#{item}\n")
        end
    end
end
