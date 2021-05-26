# require 'timeout'
# def get(url)
#     protocol = 'http'
#     port = 4567
#     Timeout.timeout(1) do
#         "#{protocol}://127.0.0.1:#{port}#{url}"
#     end
# end


# get "/lol" do
#     "Here is my text"
# end

def greet_someone
    puts "HI!!!!!"
end

alias say_hi greet_someone

say_hi