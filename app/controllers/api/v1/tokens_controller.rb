require 'net/http'
class Api::V1::TokensController  < ApplicationController
    respond_to :json
    def create
      @token = params[:token]
      if request.format != :json
        render :status=>406, :json=>{:message=>"The request must be json my brony"}
        return
       end
 
      if @token.nil?
        logger.info("User #{@token} failed signin, user cannot be found.")
        render :status=>400,
               :json=>{:message=>"Yo man this is nil yo"}
        return
      else
        facebook_feed = fb_oauth_search(@token)
        fb_uid = facebook_feed.body.split("{\"id\":\"").second.split("\"").first
        fb_name = facebook_feed.body.split("\"name\":\"").second.split("\"").first
        binding.pry
        if fb_uid != nil
          logger.info("User #{fb_name} succeeded signin, they in da' system yo.")
          render :status=>200,
                 :json=>{:message=>"Yeah bro this is cool yo"}
          return
        else
        end  
      end
    end
 
  def destroy
    render :json=>{:message=>"You've hit the token destroy page"}
    @user=User.find_by_authentication_token(params[:id])
    if @user.nil?
      logger.info("“Token not found.”")
      render :status=>404, :json=>{:message=>"”Invalid token.”"}
    else
      @user.reset_authentication_token!
      render :status=>200, :json=>{:token=>params[:id]}
    end
  end

  private
    def fb_oauth_search(oauth_token)
      url = URI.parse('https://graph.facebook.com/me?&access_token='+oauth_token)
      req = Net::HTTP::Get.new url
      res = Net::HTTP.start(url.host, url.port, 
              :use_ssl => url.scheme == 'https') {|http| http.request req}
      return res
    end
end