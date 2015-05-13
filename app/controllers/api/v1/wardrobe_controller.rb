class Api::V1::WardrobeController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json
  # def index
  #   wardrobe = Wardrobe.find(id = current_user.id)
  #   render json:wardrobe
  # end

  def index
    if params[:authentication_token] != nil
      if User.find_by_authentication_token(authentication_token = params[:authentication_token])
        @user = User.find_by_authentication_token(authentication_token = params[:authentication_token])
        @wardrobe = Wardrobe.find_by_user_id(user_id = @user.id)
        logger.info("Successful #{@user.name} connection to wardrobe json.")
        render :status =>200,
               :json=>@wardrobe
      else
        logger.info("Failed connection to wardrobe json, a user cannot be found by that authentication_token.")
        render :status =>200,
               :json=>{:message=>"Failed wardrobe connection, a user cannot be found by that authentication_token."}
      end
    else
      logger.info("Failed connection to wardrobe json, no authentication token posted.")
      render :status=>400,
            :json=>{:message=>"Did you add the user's authentication_token?"}
      return
    end
  end

  def update
    if params[:authentication_token] != nil
      if Wardrobe.find_by_authentication_token(authentication_token = params[:authentication_token])
        @wardrobe = Wardrobe.find_by_authentication_token(authentication_token = params[:authentication_token])
        @wardrobe.wardrobe = params[:wardrobe]
        @wardrobe.save!
      else
        logger.info("Failed connection to wardrobe/edit json, a wardrobe cannot be found by that authentication_token.")
        render :status =>200,
               :json=>{:message=>"Failed connection to wardrobe/edit json, a wardrobe cannot be found by that authentication_token."}
      end
    else
      logger.info("Failed connection to wardrobe/edit json, no authentication token posted.")
      render :status=>400,
            :json=>{:message=>"Did you add the wardrobe's authentication_token?"}
      return
    end
  end

  def match
    if params[:authentication_token] != nil
      if User.find_by_authentication_token(authentication_token = params[:authentication_token])
        if params[:color, :style] == nil
          logger.info("Failed connection to Naive Algo, color and style missing.")
          render :status =>200,
                 :json=>{:message=>"Failed connection to Naive Algo, please add the color and style capitalized: ie. Red Bottoms."}
        else
          binding.pry
        end
      else
        logger.info("Failed connection to wardrobe json, a user cannot be found by that authentication_token.")
        render :status =>200,
               :json=>{:message=>"Failed wardrobe connection, a user cannot be found by that authentication_token."}
      end
    else
      logger.info("Failed connection to wardrobe json, no authentication token posted.")
      render :status=>400,
            :json=>{:message=>"Did you add the user's authentication_token?"}
      return
    end
  end
end