# MyBlog --- Sample Application Layout
#
# Support the following for CRUD operations on
# a resource:
#
# * new: prepare [and serve] a resource to collect its data
# * create: store the resource data
# * find: retrieve [and serve] a resource
# * update: updates resource data
# * delete: removes resource [and/or its data]
# * index: list all of a given resource
#
# Example Resource: Post with title and body attributes
require 'sinatra'
require './models/post'

get '/' do
    # :getting_started is an erb file located
    # in the views directory by default. If you
    # would like to mage changes to the configuration
    # refer to the MyNatra docs.
    erb :getting_started
end

# instantiate and serve a post object with a form
# to collect attribute data.
get '/posts/new' do
    @post = Post.new
    erb :"posts/new"
end

# saves the post data and redirects to posts index
post '/posts/create' do
    post = Post.new
    post.title, post.body = params[:title], params[:body]
    post.save
    redirect :"posts"
end

post '/posts/update/:id' do
    post = Post.new
    post.id, post.title, post.body = params[:id].to_i, params[:title], params[:body]
    post.save
    redirect :"posts/#{post.id}"
end

get '/posts/:id' do
    @post = Post.find(params[:id].to_i)
    erb :"posts/edit"
end

post '/posts/delete/:id' do
    @post = Post.find(params[:id].to_i)
    @post.delete
    redirect :posts
end

# list all posts
get '/posts' do
    @posts = Post.all
    erb :"posts/index"
end

get '/posts/index' do
    redirect :posts
end