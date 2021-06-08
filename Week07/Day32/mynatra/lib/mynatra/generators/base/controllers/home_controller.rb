class HomeController < Sinatra::Base
  set :root, "#{File.dirname('../')}"
  
  get '/' do
    erb :home
  end
end
