class LinkedAuthController < ApplicationController
  @@app_key = "JP8s2VWQdirrzwkR4qFbJot_PYZY6dIdLAvJNGE00NR3Z6qHLd0wx7DxCWxwVsYK"
  @@app_secret = "8xXELzxc8P_Jt-0aH1_0aUtCv6xeTq4n5tY6bKiEGr0M00-YDxa054Rctltk0Mw8"
  def index
  end

  def start
    li_client = LinkedIn::Client.new(@@app_key, @@app_secret)
    request_token = li_client.request_token(:oauth_callback => 
                                          "http://#{request.host_with_port}/linked_auth/callback")
    session[:li_rtoken] = request_token.token
    session[:li_rsecret] = request_token.secret                                      
    redirect_to li_client.request_token.authorize_url
  end

  def callback
    li_client = LinkedIn::Client.new(@@app_key, @@app_secret)
        if session[:li_atoken].nil?
          pin = params[:oauth_verifier]
          atoken, asecret = li_client.authorize_from_request(session[:li_rtoken], session[:li_rsecret], pin)
          session[:li_atoken] = atoken
          session[:li_asecret] = asecret
        else
          li_client.authorize_from_access(session[:li_atoken], session[:li_asecret])
        end
        @profile = li_client.profile
        @connections = li_client.connections
        render :json => @profile
  end

  def oclient
  end

end
