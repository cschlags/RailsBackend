class Api::V1::BatchController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json
  def index
    render json:Batch.all
  end

  def show
    batch = Batch.find(params[:id])
    render json:batch
  end
end