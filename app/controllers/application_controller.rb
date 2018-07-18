class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  post '/recipes' do
    recipe = Recipe.create({name: params["name"], ingredients: params["ingredients"], cook_time: params["cook_time"]})
    redirect to '/recipes/' + recipe.id.to_s
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  delete '/recipes/:id/delete' do
    Recipe.destroy(params[:id])
    redirect to '/recipes'
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    redirect to '/recipes/' + @recipe.id.to_s
  end

  def recipe_params
    params["recipe"]
  end
end
