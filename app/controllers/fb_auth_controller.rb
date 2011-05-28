class FbAuthController < ApplicationController
  @@app_id = '230719776943529'
  @@app_secret = '9238666b7c9de13036ce422ee8897782'
  @@redirect_url = 'http://localhost:3000/fb_auth/callback'
  def index
    
  end
  
  def start
    redirect_to client.authorization.authorize_url(
      :redirect_uri => 'http://localhost:3000/fb_auth/callback' , 
      :scope => 'email,user_photos,friends_photos,publish_stream,offline_access')
  end
  
  def callback
    require 'net/http'
    require "uri"
    require 'cgi'
    
    auth_url = "https://graph.facebook.com/oauth/access_token?client_id=#{@@app_id}&redirect_uri=#{@@redirect_url}&client_secret=#{@@app_secret}&code=#{params[:code]}"
         
    uri = URI.parse(auth_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request).body
    uri_params = Hash[*response.split("&").map {|part| part.split("=") }.flatten]
    session[:fb_access_token] = uri_params['access_token']
    user_json = client.selection.me.info!.data
    
    #user = User.create({:name => user_json.name, :email => user_json.email, :access_token => session[:access_token]})
    
    render :json => user_json
  end   
  
  def oclient
    OAuth2::Client.new(@@app_id, @@app_secret, :site => 'https://graph.facebook.com')
  end   

end
