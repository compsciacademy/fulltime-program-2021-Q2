require 'sinatra'

enable :sessions

get '/' do
    erb :welcome
end  

post '/' do
    session[:name] = params[:name]
    redirect '/'
end
