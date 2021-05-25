# We want to be able to create N users.
# We also want to be able to CRUD users.
require './ui'

class App
  def call
    load_ui
  end

  def load_ui
    # Exercise 01 a) Make this work
    UI::CLI.load
  end
end

app = App.new
app.call
