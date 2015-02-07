class Api::V1::LikeController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json
  before_filter :authenticate_user!
  # def index
  #   respond_to do |format|
  #     @likes = Like.all
  #     format.json { render json:@likes}
  #   end
  # end

  def index
    like = Like.find(id = current_user.id)
    render json:like
  end

  def create
    
  end
end