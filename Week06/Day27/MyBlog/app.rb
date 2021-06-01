require 'sinatra'
require './models/user'

get '/' do
    # :getting_started is an erb file located
    # in the views directory by default. If you
    # would like to mage changes to the configuration
    # refer to the MyNatra docs.
    erb :getting_started
end

# instantiate a new user and display
# a form to get email and password
get '/user/new' do
    erb :"users/new"
end

# send email and password params from
# user form. Use this to Create(save)
# a user
post '/user/create' do; end

# find a user by email can be
# used to update a user
get '/user/:email' do
    # localhost:4567/users/drew@example.com
    # user = User.find_by_email(params[:email])
end

# replace user attribute data
# with new email and/or password data
post '/user/:email' do; end

# delete a user
post '/delete-user/:email' do
    user = User.find_by_email(params[:email])
    user.delete
    # delete user here
    redirect :users
end

get '/users/create' do
    User.create_many
    redirect :users
end

# list all users
get '/users' do
    @users = User.all
    erb :"users/index"
end
