# config/jobs.rb with Rails
require File.expand_path("../environment", __FILE__)

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

def tw_post(data)
  puts "Posting on Twitter"
  user = User.where({:_id => data['user_id']})
  puts user.inspect
  #response = oauth.request(:post, '/1/statuses/update.json?include_entities=true',
  #                         access_token, { :scheme => :query_string, :status => data['content'] })
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