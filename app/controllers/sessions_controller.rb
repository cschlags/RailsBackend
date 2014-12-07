class SessionsController < ApplicationController

  def create
    @user = User.from_omniauth(env["omniauth.auth"])
    @user.create_wardrobe
    @user.create_outfit
    @user.create_like
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

    def create_wardrobe
      @wardrobe = @user.wardrobe
      unless @wardrobe
        @wardrobe = Wardrobe.new
        @wardrobe.save!
        @user.wardrobe = @wardrobe
      end
    end

    def create_outfit
      @outfit = @user.outfit
      unless @outfit
        @outfit = Outfit.new
        @outfit.save!
        @user.outfit = @outfit
      end
    end

    def create_like
      @likes = @user.like
      unless @likes
        @likes = Like.new
        @likes.save!
        @user.like = @likes
      end
    end
end
