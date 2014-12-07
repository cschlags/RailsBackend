class Api::V1::WardrobeController < Api::ApiController
  include ActionController::MimeResponds
  def index
    respond_to do |format|
      # the specific wardrobe for that user
      @wardrobe = Wardrobe.where(["id = ?", id]).select("id").first
      format.json { render json:@wardrobe}
    end
  end
end