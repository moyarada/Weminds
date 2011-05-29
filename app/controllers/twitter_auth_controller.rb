require 'json'
require 'oauth'

class TwitterAuthController < ApplicationController
  @@api_key = "DzB7t2D9ExtpEtHdyKow"
  @@api_secret = "KIBj2OfOibAZynWleObevKJUHSVh3pKaR9Ctzmg2iKM"
  
  def start
    
    # consumer_key and consumer_secret are from Twitter.
    # You'll get them on your application details page.
    @oauth = OAuth::Consumer.new(@@api_key, @@api_secret,
                                 {:site => 'http://api.twitter.com/',
                                  :scheme => :header, 
                                 	:request_token_path => '/oauth/request_token',
                                 	:access_token_path => '/oauth/access_token',
                                 	:authorize_path => '/oauth/authorize' })

    # Ask for a token to make a request
    if (request.port == 80)
      url = "http://#{request.host}/twitter_auth/callback"
    else
      url = "http://#{request.host}:#{request.port}/twitter_auth/callback"
    end  
    request_token = @oauth.get_request_token(:oauth_callback => url)
    
    # Take a note of the token and the secret. You'll need these later
    session[:tw_token] = request_token.token
    session[:tw_secret] = request_token.secret

    # Send the user to Twitter to be authenticated
    redirect_to request_token.authorize_url
    
  end

  def callback
    oauth = OAuth::Consumer.new(@@api_key, @@api_secret,
                                 { :site => 'http://api.twitter.com',
                                   :scheme => :header,
                                   :request_endpoint => 'http://api.twitter.com', 
                                   :sign_in => true})
                                 		
    request_token = OAuth::RequestToken.new(oauth, session[:tw_token], session[:tw_secret])
                                            
    access_token = request_token.get_access_token(:auth_verifier => params[:oauth_verifier])
    
    
    #token_hash = { :oauth_token => session[:tw_token],
    #               :oauth_token_secret => session[:tw_secret],
    #               :auth_verifier => params[:oauth_verifier]
    #               }
    
    #access_token = OAuth::AccessToken.from_hash(oauth, token_hash )  
                                 
    # Get account details from Twitter
    response = oauth.request(:get, '/account/verify_credentials.json',
                             access_token, { :scheme => :query_string })    
                                                   
    # Then do stuff with the details
    user_info = JSON.parse(response.body)
    
    if (user_info['id_str']) 
      user = User.where("twitter_id" => user_info['id_str'])
      if (user.length > 0) 
        puts "Found #{user.length} users with id = #{user_info['id_str']}"
        #puts user[0].tw_access_token
        user[0].update_attributes(:tw_token => session[:tw_token], :tw_access_token => YAML::dump(access_token))
        
        puts "Authorized with Twitter - redirect to root"
        redirect_to root_path # authorized  
      else
        create = User.create({
                  :twitter_id => user_info['id_str'], :name => user_info['name'], 
                  :avatar => user_info['profile_image_url'],
                  :email => nil, :time_zone => user_info['time_zone'],
                  :tw_access_token => YAML::dump(access_token), :tw_token => session[:tw_token]
                  })
        if (create.valid?)
          puts "Users created - Redirect to ROOT"
          redirect_to :root
        else
          puts create.errors  
        end    
      end  
    else
      puts user_info.inspect
      puts "No user id found" 
    end                                                                            
  end
end