class Api::V1::BatchController < Api::ApiController
  include ActionController::MimeResponds
  def index
    respond_to do |format|
      @batches = Batch.all
      format.json { render json:@batches}
    end
  end

  def show
    respond_to do |format|
      @batch = Batch.find(params[:id])
      format.json { render json:@batch }
    end
  end
end