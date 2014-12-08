class Api::V1::LikeController < Api::ApiController
  include ActionController::MimeResponds

  def index
    respond_to do |format|
      @likes = Like.all
      format.json { render json:@likes}
    end
  end

  def show
    respond_to do |format|
      @user = User.find(params[:id])
      @like = Like.find(id = @user.id)
      format.json { render json:@like }
    end
  end
end