
begin
    raise StandardError.new("This is an error message")
rescue StandardError => e
    puts "Rescued an error: #{e.message}"
end

begin
    0 + "hello"
rescue TypeError => e
    puts "Rescued error: #{e}"
    puts "What is up?"
end
