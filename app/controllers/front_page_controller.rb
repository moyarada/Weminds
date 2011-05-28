class FrontPageController < ApplicationController
  before_filter :check_status
  
  def check_status
    if (@authorized === true)
      redirect_to :dashboard_index 
    end  
  end  
  
  def index
  end

  def show
  end

end
