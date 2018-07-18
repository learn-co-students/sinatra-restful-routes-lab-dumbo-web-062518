require 'pry'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(params)
    # binding.pry

    redirect to("/recipes/#{@recipe.id}")
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    # binding.pry

    @recipe = Recipe.find(params[:id])
    @recipe.update(params['recipe'])
    redirect to("/recipes/#{@recipe.id}")
  end

  delete '/recipes/:id/delete' do
    # Recipe.delete(params[:id])
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect to('/recipes')
  end

end
