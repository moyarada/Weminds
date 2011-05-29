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
    if (@authorized === true)
      @users = User.where(@auth_service => session[@auth_service])
    
      if (@users.length > 0)
        @user_data = @users[0]
      else
        puts "User can't be found"
      end    
    end
  end  
  

end
