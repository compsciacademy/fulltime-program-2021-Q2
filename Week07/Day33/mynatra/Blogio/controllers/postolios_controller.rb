class PostoliosController < ApplicationController
  get '/postolio/new' do
    @postolio = Postolio.new
    erb :"postolio/new"
  end
   
  post '/postolio/create' do
    postolio = Postolio.new 
    postolio.title = params[:title]
    postolio.body = params[:body]
   
    postolio.save
    redirect :"postolios"
  end

  post '/postolios/update/:id' do
    postolio = Postolio.new 
    postolio.id = params[:id]
    postolio.title = params[:title]
    postolio.body = params[:body]
   
    postolio.save
    redirect :"postolios/#{postolio.id}"
  end

  get '/postolios/:id' do
    @postolio = Postolio.find(params[:id].to_i)
    erb :"postolios/edit"
  end

  post '/postolios/delete/:id' do
    @postolio = Postolio.find(params[:id].to_i)
    @postolio.delete
    redirect :postolios
  end

  get '/postolios' do
    @postolios = Postolio.all
    erb :"postolios/index"
  end
end
