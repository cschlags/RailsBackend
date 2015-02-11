class Api::V1::UserController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json
  # before_action :doorkeeper_authorize!
  # def index
  #   user = User.find(doorkeeper_token.resource_owner_id)
  #   respond_with User.all
  # end
  def index
    if current_user != nil
      user = User.find(current_user)
      render json:user
    else
      render :json=>{:message=>"No"}
    end
  end

  def create
    puts "Hello"
  end
end
