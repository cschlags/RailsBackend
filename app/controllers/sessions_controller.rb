class SessionsController < ApplicationController

  def create
    @user = User.from_omniauth(env["omniauth.auth"])
    session[:current_user] = @user
    session[:user_id] = @user.id
    redirect_to current_user, :notice => "Congrats, you're logged in!" 
  end

  # def new 
  #   session[:return_to] = request.referer
  # end

  def destroy
    session[:user_id] = nil
    redirect_to root_url #, :notice => "Signed out!"
  end

  protected

    def auth_hash
      request.env['omniauth.auth'] 
    end

end
