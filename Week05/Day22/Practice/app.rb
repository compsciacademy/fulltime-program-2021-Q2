require 'sinatra'

enable :sessions

get '/' do
    erb :welcome
end  

post '/' do
    session[:name] = params[:name]
    redirect '/'
end

get '/settings' do
    erb :settings
end

post '/settings' do
    session[:color] = params[:color]
    session[:background_color] = params[:"background-color"]
    redirect '/settings'
end