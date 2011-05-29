class FbAuthController < ApplicationController
  @@app_id = '230719776943529'
  @@app_secret = '9238666b7c9de13036ce422ee8897782'
  @@redirect_url = 'http://localhost:3000/fb_auth/callback'
  
  def index
    
  end
  
  def client
      @fb_client ||= FBGraph::Client.new(:client_id => @@app_id,
                                     :secret_id => @@app_secret , 
                                     :token => session[:fb_token])
  end
  
  def start
    
    
    if (request.port == 80)
      @@redirect_url = "http://#{request.host}/fb_auth/callback"
    else
      @@redirect_url = "http://#{request.host}:#{request.port}/fb_auth/callback"
    end
    
    @fb_client ||= FBGraph::Client.new(:client_id => @@app_id,
                                   :secret_id => @@app_secret , 
                                   :token => session[:fb_access_token])
    
    redirect_to @fb_client.authorization.authorize_url(
      :redirect_uri => @@redirect_url , 
      :scope => 'email,publish_stream,offline_access,user_checkins,user_location,user_status,read_friendlists,user_photos')
      
      
      
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
    session[:fb_token] = uri_params['access_token']
    user_json = client.selection.me.info!.data
                        
    if (user_json.id) 
      user = User.where("facebook_id" => user_json.id)                   
      if (user.length > 0)
        if (user[0].fb_access_token && (user[0].fb_access_token <=> uri_params['access_token'])) # if access token was changed - update it  
          user.update_attributes(:fb_token => uri_params['access_token']);
          if (!user.valid?)
            puts user.errors
          end    
        end
        redirect_to root_path # authorized
      else
        create = User.create({:name => user_json.name, :email => user_json.email, 
                            :fb_token => session[:fb_token],
                            :facebook_id => user_json.id,
                            :time_zone => user_json.timezone,
                            :avatar => "#{user_json.link}/picture"
                            })
        if (create.valid?)
          redirect_to root_path
        else
          puts create.errors  
        end                    
      end    
    else
       puts user_info.inspect
       puts "No user id found"
    end      
  end   
  
  def oclient
    OAuth2::Client.new(@@app_id, @@app_secret, :site => 'https://graph.facebook.com')
  end   

end
