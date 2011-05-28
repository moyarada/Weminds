class DashboardController < ApplicationController
  before_filter :check_status
  
  def check_status
    if (@authorized === false)
      redirect_to root_path 
    end  
  end
  
  def index
    
  end

  def show
  end

  def logout
    session[@auth_service] = nil;
    @authorized = false
    redirect_to root_path
  end

end
