require 'sinatra'
require './my_form.rb'

enable :sessions

get '/' do
    erb :welcome
end  

post '/' do
    session[:name] = params[:name]
    "Thank you!"
end

get '/lol' do
    erb :hello
end
