# Write a function that returns the current
# "time range" --- which is one of:
# morning, afternoon, evening, night

def current_time_range
  time = Time.now

  if time.hour < 12
    "morning"
  elsif time.hour < 17
    "afternoon"
  elsif time.hour < 21
    "evening"
  else
    "night"
  end
end

puts "Good #{current_time_range}!"
