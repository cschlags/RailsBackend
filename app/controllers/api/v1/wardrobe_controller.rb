class Api::V1::WardrobeController < Api::ApiController
  include ActionController::MimeResponds
  def index
    respond_to do |format|
      @wardrobes = Wardrobe.all
      format.json { render json:@wardrobes}
    end
  end
end