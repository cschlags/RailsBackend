class Api::V1::WardrobeController < Api::ApiController
  include ActionController::MimeResponds
  def index
    respond_to do |format|
      @wardrobe = Wardrobe.find(this.user.id)
      format.json { render json:@wardrobe}
    end
  end
end