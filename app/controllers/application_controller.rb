require 'pry'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/recipes' do
  	@recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
  	erb :new
  end

  post '/recipes' do
  	# binding.pry
  	recipe = Recipe.new(params)
  	recipe.save
  	redirect to("/recipes/#{recipe.id}")
  end

  get '/recipes/:id' do
  	@recipe = Recipe.find_by_id(params[:id])
  	erb :show
  end

  delete '/recipes/:id/delete' do
  	recipe = Recipe.find_by_id(params[:id])
  	recipe.destroy
  	redirect to "/recipes"
  end

  get '/recipes/:id/edit' do
  	@recipe = Recipe.find_by_id(params[:id])
  	erb :edit
  end

  patch '/recipes/:id' do
  	recipe = Recipe.find_by_id(params[:id])
  	recipe.ingredients = params[:ingredients]
  	recipe.name = params[:name]
  	recipe.cook_time = params[:cook_time]
  	recipe.save
  	redirect to("/recipes/#{recipe.id}")
  end

end