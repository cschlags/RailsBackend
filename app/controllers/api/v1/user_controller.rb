class Api::V1::UserController < Api::ApiController
  include ActionController::MimeResponds
  before_action :doorkeeper_authorize!
  def index
    user = User.find(doorkeeper_token.resource_owner_id)
    format.json { render json:user }
  end
  def show
    respond_to do |format|
      @user = User.find(params[:id])
      format.json { render json:@user }
    end
  end
end
