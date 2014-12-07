class Api::V1::WardrobeController < Api::ApiController
  include ActionController::MimeResponds
  def index
    respond_to do |format|
      @wardrobe = Wardrobe.where(["user_id = ?", 1])
      format.json { render json:@wardrobe}
    end
  end
end