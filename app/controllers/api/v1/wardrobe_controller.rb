class Api::V1::WardrobeController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json
  def index
    wardrobe = Wardrobe.find(id = current_user.id)
    render json:wardrobe
  end

  # def index
  #   respond_to do |format|
  #     @wardrobe = Wardrobe.all
  #     format.json { render json:@wardrobe}
  #   end
  # end
end