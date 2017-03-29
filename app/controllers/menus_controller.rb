class MenusController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :generate_proxy_request, except: [:new]

  def index
    @menus = @proxy_request.get_menus
  end

  def new
    render 'new', layout: false
  end

  def create
    @menu = @proxy_request.create_a_menu(params[:title])
    if @menu['code'] < 400
      flash[:success] = "Menu successfully created"
      render partial: 'menus_index', locals: { menu: @menu }
    else
      flash[:danger] = "Something went wrong! Please try again."
      render 'new'
    end
  end

  def show
    @menu = @proxy_request.get_menu_title(params[:id])
    @menu_recipes = @proxy_request.list_menu_recipes(params[:id])
    @recipes = @proxy_request.get_recipes
  end

  def edit
    @menu = @proxy_request.get_menu_title(params[:id])
    @path = "/menus/#{params[:id]}"
    render 'edit', layout: false
  end

  def update
    @menu = @proxy_request.update_menu(params[:id], params[:title])
    render partial: 'menus_index', locals: { menu: @menu }
  end

  def destroy
    @menu = @proxy_request.delete_menu(params[:id])
    head :no_content, status: :ok
  end

end
