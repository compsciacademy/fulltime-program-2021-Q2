require 'benchmark'
def rand_word(num=3)
  ('a'..'z').to_a.sample(num).join
end

def rand_title_one
  title = ''
  5.times do
    title += rand_word.capitalize + ' '
  end
  title.rstrip!
end

# could be rewritten to:
def rand_title_two
  5.times.map do
    rand_word(8).capitalize + ' '
  end.join(' ').rstrip!
end

# we can take this a step further
def rand_title_three
  Array.new(4) do
    rand_word(5).capitalize + ' '
  end.join(' ').rstrip!
end

n = 10000

Benchmark.bm(10) do |x|
  x.report("one: ") { n.times { rand_title_one }}
  x.report("two: ") { n.times { rand_title_two }}
  x.report("three: ") { n.times {rand_title_three }}
end
