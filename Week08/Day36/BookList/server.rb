require 'sinatra'
require 'mongoid'

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
end

get '/' do
  '<h1>Book List</h1>'
end
