class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/' do

    "THIS PAGE IS WORKING"
  end
  get '/recipes' do
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    erb :deleted
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    # binding.pry
    @recipe.update(params[:recipe])
    redirect to "/recipes/#{@recipe.id}"
  end


  post '/recipes' do
    # binding.pry
    recipe = Recipe.create(params)
    redirect to "/recipes/#{recipe.id}"
  end

end
