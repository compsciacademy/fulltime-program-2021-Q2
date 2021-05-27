module Form
  def self.show(filename)
    # read the file given by the
    # filename argument, and return
    # a string value that can be 
    # presented in the browser view.
    # e.g. the contents of the file
    # form.html should return this:
    "<form method='POST' action='/'>" \
    "<input name='name'><br>" \
    "<input type='submit'>" \
    "</form>"

    File.open(filename, 'r') do |file|
      file.map do |line|
        # if line.include?("<%")
        #
        # Question: How should this differentiate between
        # something like:
        #
        #  people.each do |person|
        #     person.to_s
        #  end
        #
        # and say something like:
        #
        # session[:color] = params[:color]
        #
        # Here's some light reading for inspiration:
        # https://github.com/ruby/ruby/blob/master/lib/erb.rb
        #
        #
        #
        #   eval_code(line)
        # else
          line
        # end
      end
    end

    def eval_code(line)
      # do something with line
      # (basically take what is between
      # <% and %> and evaluate it as ruby
      # code, then return the result)
    end
  end
end
