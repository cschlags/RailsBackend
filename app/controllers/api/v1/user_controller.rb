class Api::V1::UserController < Api::ApiController
  include ActionController::MimeResponds
  def index
    respond_to do |format|
      @users = User.all
      format.json { render json:@users}
    end
  end
end
