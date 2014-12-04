class UserController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json # added for AJAX

  # GET /users
  # GET /users.json
  def index
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # unless current_user.id == params[:id].to_i
    #   redirect_to root_url
    # end
  end

  # GET /users/new
  def new
    redirect_to root_url
  end

  # GET /users/1/edit
  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

end
