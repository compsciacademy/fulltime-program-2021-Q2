# from:
# https://andrewberls.com/blog/post/naked-asterisk-parameters-in-ruby
#

class Bar
  def save(*args)
    puts "Args passed to superclass Bar#save: #{args.inspect}"
  end
end
 
class Foo < Bar
  def save(*)
    puts "Entered Foo#save"
    super
  end
end
 
Foo.new.save("one", "two")
