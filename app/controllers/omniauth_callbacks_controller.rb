class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    current_user = @user
    
    if @user.persisted?
      redirect_to "/wardrobe"
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to "/"
    end
  end
end