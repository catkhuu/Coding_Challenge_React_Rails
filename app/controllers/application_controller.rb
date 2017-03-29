class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :generate_proxy_request
  include SessionsHelper

  protected

  def generate_proxy_request
    @proxy_request = Request.new
  end
end
