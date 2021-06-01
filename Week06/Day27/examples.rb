require 'sinatra'

get '/:name' do
  "<h1>Hello #{params[:name]}</h1>!"
end
