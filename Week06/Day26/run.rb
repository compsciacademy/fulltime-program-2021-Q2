require './lol'

class App
    def run
        Lol.new.info
        puts "I am run.rb: #{__FILE__}"
    end
end

App.new.run
