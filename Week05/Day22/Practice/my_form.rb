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
        if line.includes("<%")
          eval_code(line)
        else
          line
        end
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
