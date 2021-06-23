require 'sinatra'
require 'mongoid'

# load mongoid config
Mongoid.load! 'mongoid_config.yml'

######################
#  Models
######################
class Post
  include Mongoid::Document

  field :title
  field :body

  has_many :comments
end

class Comment
  include Mongoid::Document

  field :name
  field :message

  belongs_to :post
end

######################
#  Routes
######################
get '/' do
  "<h1>Hello!</h1>"
end


get '/posts' do
  Post.all.to_json
end

post '/posts' do
  post = Post.create(params[:post])
  post.to_json
end

get '/posts/:id' do |id|
  post = Post.find(id)
  # post.attributes.merge(
  #   comments: post.comments
  # ).to_json
  {
    post: post,
    comments: post.comments
  }.to_json

end

post '/posts/:post_id/comments' do |post_id|
  post = Post.find(post_id)
  comment = post.comments.create(params[:comment])
  {}.to_json
end
