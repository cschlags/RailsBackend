class Api::V1::OutfitController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json
  # def index
  #   respond_to do |format|
  #     @outfits = Outfit.all
  #     format.json { render json:@outfits}
  #   end
  # end

  def index
    outfit = Outfit.find(id = current_user.id)
    render json:outfit
  end
end