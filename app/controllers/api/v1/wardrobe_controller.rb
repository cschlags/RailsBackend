class Api::V1::WardrobeController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json
  before_filter :authenticate_user!
  def index
    wardrobe = Wardrobe.find(id = current_user.id)
    render json:wardrobe
  end

  def create
    
  end
end