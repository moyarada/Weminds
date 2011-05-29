class DashboardController < ApplicationController
  before_filter :check_status
  
  def check_status
    if (@authorized == false)
      redirect_to root_path 
    end  
  end
  
  def index
    
  end

  def show
  end
  
  # POST /dashboard/ask
  def ask
    puts user_data.inspect
    question = user_data.questions.create({:content => params[:question], :source => 'weminds', 
                                          :created_on => Time.now, :post_on => params[:post_on], :post_statuses => nil})
    
    if (question.valid?)
      #TODO run post tasks
      @status = :ok;
      @msg = "Your question was successfuly posted!"
    else
      @status = :error
      @msg = question.errors
    end   
    respond_to do |format|
      #format.html
      #format.xml { render :xml => @posts.to_xml }
      format.json { render :json => {:status => @status, :message => @msg} }
    end
         
  end  
  
  # GET /dashboard/myquestions
  def myquestions
    puts user_data.inspect

    questions = user_data.questions #Question.where(:user_id => user_data.id)
    
    respond_to do |format|
      #format.html
      #format.xml { render :xml => @posts.to_xml }
      format.json { render :json => questions }
    end
    
  end  

  def logout
    session[@auth_service] = nil;
    @authorized = false
    puts user_data.inspect
    redirect_to root_path
  end

end
