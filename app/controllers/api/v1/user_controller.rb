class Api::V1::UserController < Api::ApiController
  respond_to :json
  def index
    @users = User.all
    respond_with @users
  end
end