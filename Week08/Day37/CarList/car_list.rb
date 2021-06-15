require 'sinatra'
require 'sinatra/namespace'
require 'mongoid'

Mongoid.load! 'mongoid_config.yml'

class Car
  include Mongoid::Document

  field :brand
  field :model
  field :color
  field :year, type: Integer

  validates :brand, :model, :color, presence: true
  validates :year, numericality: { only_integer: true }, length: { is: 4 }


end

class Serializer
  def initialize(car)
    @car = car
  end

  def as_json(*)
    fields = {
      id: @car.id.to_s,
      brand: @car.brand,
      model: @car.model,
      color: @car.color,
      year: @car.year
    }
    fields[:errors] = @car.errors if @car.errors.any?
    fields
  end
end

get '/' do
  redirect :"/api/cars"
end

namespace '/api' do
  before do
    content_type 'application/json'
  end

  get '/cars' do
    Car.all.map { |car| Serializer.new(car) }.to_json
  end

  get '/cars/:id' do |id|
    car = Car.where(id: id).first
    unless car
      halt(404, { message: 'unable to find a car with that id' }.to_json )
    end
    Serializer.new(car).to_json
  end
end
