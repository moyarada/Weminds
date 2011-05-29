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
  
  # POST /dashboard/ask
  def ask
    puts params.inspect
    #question = @user_data.questions.build({:content => params[:question], :source => 'weminds', 
    #                                       :created_on => Time.now, :post_on => params[:post_on], :post_statuses => nil})
    
    #if (question.valid?)
      #TODO run post tasks
    #else
      #@errors = question.errors
    #end    
  end  
  
  # GET /dashboard/myquestions
  def myquestions
    #questions = User.
  end  

  def logout
    session[@auth_service] = nil;
    @authorized = false
    redirect_to root_path
  end

end
