class Api::V1::WardrobeController < Api::ApiController
  include ActionController::MimeResponds
  def index
    respond_to do |format|
      # the specific wardrobe for that user
      @wardrobe = Wardrobe.find(this.id)
      format.json { render json:@wardrobe}
    end
  end
end