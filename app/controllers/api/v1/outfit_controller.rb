class Api::V1::OutfitController < Api::ApiController
  include ActionController::MimeResponds
  def index
    respond_to do |format|
      @outfits = Outfit.where(["user_id = ?", 1])
      format.json { render json:@outfits}
    end
  end
end