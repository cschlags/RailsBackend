class Api::V1::OutfitController < Api::ApiController
  include ActionController::MimeResponds
  def index
    respond_to do |format|
      @outfits = Outfit.all
      format.json { render json:@outfits}
    end
  end
end