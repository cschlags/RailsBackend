class Api::V1::LikeController < Api::ApiController
  include ActionController::MimeResponds
  def index
    respond_to do |format|
      @likes = Like.where(["user_id = ?", 1])
      format.json { render json:@likes}
    end
  end
end