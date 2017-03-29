class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]
  skip_before_action :generate_proxy_request

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params[:sessions][:username])
    if @user && @user.authenticate(params[:sessions][:password])
      session[:user_id] = @user.id
      redirect_to menus_path
    else
      @errors = ['Invalid username or password']
      render 'new'
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
