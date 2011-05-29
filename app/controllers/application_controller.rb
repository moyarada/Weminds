class ApplicationController < ActionController::Base
  protect_from_forgery
  
  
  @authorized = false
  @auth_service = nil
  
  before_filter :authorize
  
  def authorized?
    @authorized
  end
  
  def authorize
    
    if (!session[:wm_session_code])
      puts "Generate WM Pass"
      o =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten;  
      string  =  (0..50).map{ o[rand(o.length)]  }.join;
      session[:wm_session_code] = string
    end
    
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
    puts "Authorize!"
    puts @authorized
    if (@authorized == true)
      @users = User.where("#{@auth_service}" => session[@auth_service])
      if (@users.length > 0)
        @user_data = @users[0]
        puts @user_data.inspect
      else
        puts "User can't be found"
      end    
    end
  end  
  
  def user_data
    @user_data
  end  
  

end
