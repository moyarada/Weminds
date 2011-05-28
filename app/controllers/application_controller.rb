class ApplicationController < ActionController::Base
  protect_from_forgery
  @@app_id = '230719776943529'
  @@app_secret = '9238666b7c9de13036ce422ee8897782'
  @authorized = false
  @auth_service = nil
  
  before_filter :authorize, :except => [:show, :search]
  
  def authorized?
    @authorized
  end
  
  def client
      @fb_client ||= FBGraph::Client.new(:client_id => @@app_id,
                                     :secret_id => @@app_secret , 
                                     :token => session[:access_token])
  end
  
  def authorize
    
    if (session[:tw_token])
      @authorized = true
      @auth_service = "tw_token"
    end 
    
    if (session[:fb_token])
      @authorized = true
      @auth_service = "fb_token"
    end
    
    if (session[:li_token])
      @authorized = true
      @auth_service = "li_token"
    end   
    puts @authorized
  end  
  

end
