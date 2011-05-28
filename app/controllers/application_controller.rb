class ApplicationController < ActionController::Base
  protect_from_forgery
  @@app_id = '230719776943529'
  @@app_secret = '9238666b7c9de13036ce422ee8897782'
  
  def client
      @fb_client ||= FBGraph::Client.new(:client_id => @@app_id,
                                     :secret_id => @@app_secret , 
                                     :token => session[:access_token])
  end
  

end
