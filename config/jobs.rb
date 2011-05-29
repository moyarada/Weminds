# config/jobs.rb with Rails
require File.expand_path("../environment", __FILE__)
require 'yaml'
@api_key = "DzB7t2D9ExtpEtHdyKow"
@api_secret = "KIBj2OfOibAZynWleObevKJUHSVh3pKaR9Ctzmg2iKM"

job "post_question" do |args|
  puts "Posting on selected networks with #{args.inspect}"
  data = args["question"]
  nets = data["post_on"]
  
  map = nets.each_key do |key|
    
    if (key == "facebook" && nets[key] == 'true')
      fb_post(data)
    end  
    
    if (key == "twitter" && nets[key] == 'true')
      tw_post(data)
    end
   
  end
  
end

error do |e, job, args|
  Exceptional.handle(e)
end

def tw_post(data)
  
  #Twitter.configure do |config|
  #  config.consumer_key = "DzB7t2D9ExtpEtHdyKow"
  #  config.consumer_secret = "KIBj2OfOibAZynWleObevKJUHSVh3pKaR9Ctzmg2iKM"
  #  config.oauth_token = "10826832-yrgfnhm1n1pMw2qVX4aIq7WbCNF7eRb8Qis5mfs0n"
  #  config.oauth_token_secret = "VtCp2ZGCmMugv7agxE6jGi2PEoJsbllO8Do643vxYs"
  #end
  
  #client = Twitter::Client.new
  
  #client.update(data['content']);
  
  #puts "Posting on Twitter"
  user = User.find(data['user_id'])
  atoken = YAML::load(user['tw_access_token'])
  response = atoken.post('/1/statuses/update.json', {:status => data['content']})
  #atoken.request(:post, 'http://api.twitter.com/1/statuses/update.json', "status=#{data['content']}")   #.post('/1/statuses/update.json', "status=#{data['content']}")
  
  #Twitter.configure do |config|
  #  config.consumer_key       = atoken.key
  #  config.consumer_secret    = atoken.secret #{}"KIBj2OfOibAZynWleObevKJUHSVh3pKaR9Ctzmg2iKM"
  #  config.oauth_token        = atoken.token
  #  config.oauth_token_secret = atoken.oauth_token_secret
  #end
  
  #client = Twitter::Client.new
  #client.update(data['content'])
  
  
  
  #oauth = OAuth::Consumer.new("DzB7t2D9ExtpEtHdyKow", "KIBj2OfOibAZynWleObevKJUHSVh3pKaR9Ctzmg2iKM",  { :site => 'http://api.twitter.com/',
  #  :scheme => :header})
  
  #puts data['content']                             		
  #response = oauth.request(:post, '/1/statuses/update.json',
  #                         atoken, {:scheme => :header}, "status=#{data['content']}")
  
  puts response.body                          
end  

def fb_post(data)
  puts "Posting on FB"
end  

job "twitter.post" do |args|
  puts "Posting on twitter with #{args.inspect}"
  
end

job "facebook.post" do |args|
  puts "Posting on FB with #{args.inspect}"
end

job "twitter.fetch_replies" do |args|
  puts "Fetch from Twitter: #{args.inspect}"
end

job "facebook.fetch_replies" do |args|
  puts "Fetch from FB: #{args.inspect}"
end