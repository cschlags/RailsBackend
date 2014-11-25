class UserController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json # added for AJAX

  # GET /users/1
  # GET /users/1.json
  # shows the current_user's information
  def show
    unless current_user.id == params[:id].to_i
      redirect_to user_page
    end
  end
  # GET /users/1/edit
  # allows user to edit their information
  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

end
