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

  def as_json(*)
    fields = {
      id: self.id.to_s,
      brand: self.brand,
      model: self.model,
      color: self.color,
      year: self.year
    }
    fields[:errors] = self.errors if self.errors.any?
    fields
  end
end

get '/' do
  redirect :"/api/cars"
end

namespace '/api' do
  before do
    content_type 'application/json'
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  options '*' do
    response.headers['Access-Control-Allow-Methods'] = ['PATCH', 'DELETE']
  end

  get '/cars' do
    # Car.all.map { |car| Serializer.new(car) }.to_json
    Car.all.to_json
  end

  get '/cars/:id' do |id|
    car = Car.where(id: id).first
    unless car
      halt(404, { message: 'unable to find a car with that id' }.to_json )
    end
    car.to_json
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

  post '/cars' do
    begin
      car = Car.new(request_params)
    rescue
      halt 406, { message: 'Incorrect params!'}.to_json
    end

    if car.save
      host_address = "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
      response.headers['Location'] = "#{host_address}/api/cars/#{car.id}"
      status 201
      body car.to_json
    else
      status 422
      body request_params
    end
  end

  patch '/cars/:id' do |id|
    car = Car.where(id: id).first
    unless car
      halt 404, { message: 'Cannot find a car with that id' }.to_json
    end

    if car.update(request_params)
    else
      status 422
      body request_params
    end
  end

  delete '/cars/:id' do |id|
    car = Car.where(id: id).first
    car.destroy if car 
    status 204
  end
end
