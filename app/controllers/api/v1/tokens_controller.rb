require 'net/http'
class Api::V1::TokensController  < ApplicationController
    respond_to :json
    TOKEN = "123"
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
      elsif @token = TOKEN
        # facebook_feed = fb_oauth_search(@token)

        # if facebook_feed.uid != nil
          logger.info("User #{@token} succeeded signin, they in da' system yo.")
          render :status=>200,
                 :json=>{:message=>"Yeah bro this is cool yo"}
          return
        # else
        # end  
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
    def fb_oauth_search(access_token)
      binding.pry
      url = URI.parse('https://graph.facebook.com/me?fields=id&access_token='+@accesstoken)
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      binding.pry
      puts res.body
    end
end