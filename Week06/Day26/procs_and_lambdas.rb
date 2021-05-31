# What's the difference between a proc and a lambda?
#
# To really understand the difference, let's put them both to use.

# Instiate a proc and a lambda
l = lambda { |x, y| x.times { puts y } }
# p = Proc.new { |x, y| x.times { puts y } }
p = proc { |x, y| x.times { puts y } }

# Take note of what type of class each of these are
# l.class
# p.class

# When envoking lambdas and procs, we use `call`, e.g.
# Try calling each to see what they do with both the 
# correct number of arguments, and too many arguments 
# (or even not enough)
# l.call 1, 2
# l.call 1, 2, 3, 4
# l.call 6
# p.call 1, 2
# p.call 1, 2, 3, 4
# p.call 6

# Define a method that takes a proc or lambda as a
# parareter and runs some code without passing the
# parameters to the proc.
def proc_tester_without_params(lambda_or_proc)
  a = 3
  b = 2
  puts a + b
  lambda_or_proc.call
  c = a * b
  puts c
end

# Define a method that takes a proc or lamdba as a 
# parameter and runs some code that passes too many
# arguments to it
def proc_tester_with_many_params(lambda_or_proc)
  a = 3
  b = 2
  puts a + b
  lambda_or_proc.call(1, 2, 3, 4)
  c = a * b
  puts c
end

# Pass procs and lamdbas into the methods and observe
# the outcome...
proc_tester_without_params l
proc_tester_without_params p

proc_tester_with_many_params l
proc_tester_with_many_params p
