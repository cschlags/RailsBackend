class Api::V1::WardrobeController < Api::ApiController
  include ActionController::MimeResponds
  def index
    respond_to do |format|
      @wardrobe = Wardrobe.all
      format.json { render json:@wardrobe}
    end
  end

  def show
    respond_to do |format|
      @user = User.find(params[:id])
      @wardrobe = Wardrobe.find(id = @user.id)
      format.json { render json:@wardrobe }
    end
  end
end