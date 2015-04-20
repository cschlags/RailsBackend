class Api::V1::BatchController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json
  def index
    if params[:batch_folder] != nil && params[:batch_number] == nil
      @tops = Tops.where(batch_folder: params[:batch_folder]).pluck(:id, :batch_folder, :batch_number, :file_name, :url, :properties)
      render json: @tops
    elsif params[:batch_folder] != nil && params[:batch_number] != nil
      @tops = Tops.where(batch_folder: params[:batch_folder]).where(batch_number: params[:batch_number]).pluck(:id, :batch_folder, :batch_number, :file_name, :url, :properties)
      render json: @tops
    else
        logger.info("Failed reading of batch, please add batch_folder and batch_number, for batch folders please visit the batch index")
        render :status =>200,
               :json=>{:message=>"Failed reading of batch, please add batch_folder and batch_number, for batch folders please visit the batch index"}
    end
  end
end