require 'sinatra'

get '/' do
    "<form method='POST' action='/'>" \
    "<input name='name'><br>" \
    "<input type='submit'>" \
    "</form>"
end  

post '/' do
    "Hello #{params[:name]}!"
end
