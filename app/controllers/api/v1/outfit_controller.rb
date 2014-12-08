class Api::V1::OutfitController < Api::ApiController
  include ActionController::MimeResponds
  
  def index
    respond_to do |format|
      @outfits = Outfit.all
      format.json { render json:@outfits}
    end
  end

  def show
    respond_to do |format|
      @user = User.find(params[:id])
      @outfit = Outfit.find(id = @user.id)
      format.json { render json:@outfit }
    end
  end
end