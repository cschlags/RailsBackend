class Api::ApiController < ActionController::API
  helper_method :current_user
  
  private
  def current_user
    @current_user ||= User.find(session[:uid]) if session[:uid]
  end
end