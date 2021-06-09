class ApplicationController < Sinatra::Base
  configure do
    set :root, "#{File.dirname('../')}"
  end
end