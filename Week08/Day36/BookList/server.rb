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

end
