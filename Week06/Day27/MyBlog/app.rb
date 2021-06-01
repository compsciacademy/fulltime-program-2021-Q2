require 'sinatra'

get '/' do
    # :getting_started is an erb file located
    # in the views directory by default. If you
    # would like to mage changes to the configuration
    # refer to the MyNatra docs.
    erb :getting_started
end
