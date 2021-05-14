

puts "Keys  |  Values"
ENV.each do |key, value|
    puts "#{key}: #{value}"
end
