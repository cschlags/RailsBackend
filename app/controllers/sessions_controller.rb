class SessionsController < ApplicationController
  def create
    @user = User.from_omniauth(env["omniauth.auth"])
    session[:current_user] = @user
    session[:user_id] = @user.id
    redirect_to wardrobe_index_path, :notice => "Congrats, you're logged in!" 
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "You've logged out"
  end

  protected
    def auth_hash
      request.env['omniauth.auth'] 
    end
end
