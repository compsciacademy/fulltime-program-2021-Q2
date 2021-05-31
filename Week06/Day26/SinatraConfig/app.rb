require 'sinatra'

set :root, File.dirname(__FILE__)
set :public_folder, Proc.new { File.join(root, "assets") }

get '/' do
    erb :index
end

