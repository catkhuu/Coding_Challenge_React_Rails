class MenuRecipesController < ApplicationController
  before_action :require_login, :generate_proxy_request
  before_action :set_menu, only: [:new, :destroy]

  def new
    @recipes = @proxy_request.get_recipes
  end

  def create
    @menu_recipe = @proxy_request.add_recipe_to_menu(params[:menu_id], params[:recipe_id])
    rescue_from_error(@menu_recipe, menu_path(params[:menu_id]))
  end

  def destroy
    @menu_recipe = @proxy_request.remove_recipe_from_menu(params[:menu_id], params[:recipe_id])
    rescue_from_error(@menu_recipe, menu_path(params[:menu_id]))
  end


  private

  def set_menu
    render 'application/error_404' unless @menu = @proxy_request.get_menu_title(params[:menu_id])
  end

  def rescue_from_error(response, path)
    if response['code'] < 400
      redirect_to path
    else
      render 'application/error_404'
    end
  end

end
