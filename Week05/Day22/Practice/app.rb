require 'sinatra'
require './my_form.rb'

get '/' do
    Form.show('form.html')
end  

post '/' do
    "Hello #{params[:name]}!"
end

get '/lol' do
    erb :hello
end
