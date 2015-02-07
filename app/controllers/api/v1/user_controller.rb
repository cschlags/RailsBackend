class Api::V1::UserController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json
  before_filter :authenticate_user!
  # before_action :doorkeeper_authorize!
  # def index
  #   user = User.find(doorkeeper_token.resource_owner_id)
  #   respond_with User.all
  # end
  def index
    user = User.find(current_user)
    render json:user
  end

  def create
    puts "Hello"
  end
end
