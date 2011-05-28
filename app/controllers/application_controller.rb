class ApplicationController < ActionController::Base
  protect_from_forgery

  @authorized = false
  @auth_service = nil
  
  before_filter :authorize, :except => [:show, :search]
  
  def authorized?
    @authorized
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
