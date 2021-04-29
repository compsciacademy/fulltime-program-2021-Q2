# Day 04

Today, we'll continue with where we left off. We have discussed some data types, data structures, Classes and Objects, CLI I/O and File I/O.

## Review

```ruby
# this should print a triangle based on the number
# passed in as count.
# e.g.
# triangle(4)
#    0
#   0 0
#  0 0 0
# 0 0 0 0

# ----

# represent a triangle in an array or rows
# where each row is a string.
# e.g. triangle(3) is:
#   0
#  0 0
# 0 0 0
# 
# In an array representation, this will look
# like this: 
# ['  0', ' 0 0', '0 0 0']
def triangle(count, symbol="0")
    rows = []
    padding = ''
    while count > 0 do
        rows[count-1] = padding
        count.times do
            rows[count-1] += "#{symbol} "
        end
        padding += ' '
        count -= 1
    end
    rows
end

puts triangle(33, '#')
```

