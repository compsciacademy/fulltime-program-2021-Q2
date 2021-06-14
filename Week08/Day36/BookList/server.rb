require 'sinatra'
require 'mongoid'
require 'sinatra/namespace'

# load mongoid config
Mongoid::load! 'mongoid_config.yml'

class Book
  include Mongoid::Document

  field :title, type: String
  field :author, type: String
  field :isbn, type: String

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true

  scope :by_author, ->(author_name) { where(author: author_name) }
end

get '/' do
  '<h1>Book List</h1>'
end

namespace '/v1' do
  before do
    content_type 'application/json'
  end

  get '/books' do
    books = Book.all

    if params[:author]
      books = books.send(:by_author, params[:author])
    end

    books.to_json
  end

  post '/books' do 
    puts ">>>>>>>>>>>>>>>>>>>>>>>>"
    puts ">>>>>>>>>>>>>>>>>>>>>>>>"
    puts ">>>>>>>>>>>>>>>>>>>>>>>>"
    puts request.body.read
    puts ">>>>>>>>>>>>>>>>>>>>>>>>"
    puts ">>>>>>>>>>>>>>>>>>>>>>>>"
    puts ">>>>>>>>>>>>>>>>>>>>>>>>"
    
    book_params = begin
      JSON.parse(request.body.read)
    rescue
      halt 400, { message: 'Bad JSON syntax' }.to_json
    end
  
    begin
      Book.create(book_params)
      status 200
    rescue
      halt 422, { message: "Could not save book with given params" }.to_json
    end
  end
end
