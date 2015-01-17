class Api::V1::UserController < Api::ApiController
  include ActionController::MimeResponds
  # before_action :authenticate
  def index
    respond_to do |format|
      @users = User.all
      format.json { render json:@users }
    end
  end
  def show
    respond_to do |format|
      @user = User.find(params[:id])
      format.json { render json:@user }
    end
  end
end
