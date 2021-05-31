require_relative './what/yo'

class Lol
    def info
        Yo.new.info
        puts "I am lol.rb: #{__FILE__}"
    end
end
