class Api::V1::LikeController < Api::ApiController
  include ActionController::MimeResponds
  def index
    respond_to do |format|
      @likes = Like.all
      format.json { render json:@likes}
    end
  end
end