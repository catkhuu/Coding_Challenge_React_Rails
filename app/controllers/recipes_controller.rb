class RecipesController < ApplicationController
  before_action :require_login, except: [:show, :index]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = @proxy_request.get_recipes
  end

  def new
    if request.xhr?
      render 'new', layout: false
    end 
  end

  def create
    @recipe = @proxy_request.create_recipe(params[:description], params[:name])
    rescue_from_error(@recipe, recipes_path)
  end

  def show
  end

  def edit
  end

  def update
    @recipe = @proxy_request.update_recipe(params[:description], params[:name], params[:id])
    redirect_to recipe_path(@recipe['id'])
  end

  def destroy
    @recipe = @proxy_request.delete_recipe(params[:id])
    rescue_from_error(@recipe, recipes_path)
  end

  private

  def set_recipe
    render 'application/error_404' unless @recipe = @proxy_request.get_recipe_description(params[:id])
  end

  def rescue_from_error(response, path)
    if response['code'] < 400
      redirect_to path
    else
      render 'application/error_404'
    end
  end

end
