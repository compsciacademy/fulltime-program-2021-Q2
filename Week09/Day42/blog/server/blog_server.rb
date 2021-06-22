require 'sinatra'
require 'sinatra/namespace'
require 'mongoid'

Mongoid.load! 'mongoid_config.yml'

class Post
  include Mongoid::Document

  field :title
  field :body

  validates :title, :body, presence: true

  def self.page(offset_amount, limit_amount)
    all.offset(offset_amount).limit(limit_amount)
  end

  def as_json(*)
    fields = {
      id: self.id.to_s,
      title: self.title,
      body: self.body
    }
    fields[:errors] = self.errors if self.errors.any?
    fields
  end
end

get '/' do
  redirect :"/api/posts"
end

namespace '/api' do
  before do
    content_type 'application/json'
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  options '*' do
    response.headers['Access-Control-Allow-Methods'] = 'PATCH, DELETE'
  end

  get '/posts/paginated/:offset' do
    {
      "count": Post.count,
      "posts": Post.page(params[:offset], 5)
    }.to_json
  end

  get '/posts' do
    Post.all.to_json
  end

  get '/posts/:id' do |id|
    post = Post.where(id: id).first
    unless post
      halt(404, { message: 'unable to find a post with that id' }.to_json )
    end
    post.to_json
  end

  helpers do
    def request_params
    # read the request body and attempt to parse JSON
      begin
        JSON.parse(request.body.read)
      rescue
        halt 400, { message: 'The JSON was unparsable' }.to_json
      end
    end
  end

  post '/posts' do
    begin
      post = Post.new(request_params)
    rescue
      halt 406, { message: 'Incorrect params!'}.to_json
    end

    if post.save
      host_address = "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
      response.headers['Location'] = "#{host_address}/api/posts/#{post.id}"
      status 201
      body post.to_json
    else
      status 422
      body request_params
    end
  end

  patch '/posts/:id' do |id|
    post = Post.where(id: id).first
    unless post
      halt 404, { message: 'Cannot find a post with that id' }.to_json
    end

    if post.update(request_params)
    else
      status 422
      body request_params
    end
  end

  delete '/posts/:id' do |id|
    post = Post.where(id: id).first
    post.destroy if post 
    status 204
  end
end
