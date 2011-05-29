# config/jobs.rb with Rails
require File.expand_path("../environment", __FILE__)

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