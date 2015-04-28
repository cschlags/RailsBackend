class Api::V1::BatchController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json
  def index
    if Tops.count > 1
      render json: Tops.all
    else
      logger.info("Oh damn the batches aren't here! Call Christina or run 'heroku run rake read_aws'")
      render :status =>200,
             :json=>{:message=>"Shit there aren't any batches in here"}
    end
  end
end