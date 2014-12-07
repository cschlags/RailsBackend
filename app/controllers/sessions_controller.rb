class SessionsController < ApplicationController

  def create
    @user = User.from_omniauth(env["omniauth.auth"])
    @wardrobe = @user.wardrobe
    unless @wardrobe
      @wardrobe = Wardrobe.new
      @wardrobe.save!
      @user.wardrobe = @wardrobe
    end
    session[:current_user] = @user
    session[:user_id] = @user.id
    redirect_to wardrobe_index_path 
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  protected

    def auth_hash
      request.env['omniauth.auth'] 
    end

end
