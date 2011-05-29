class User
  include Mongoid::Document
  
  field :email, :type => String
  field :name, :type => String
  field :surname, :type => String
  field :twitter_id, :type => String
  field :facebook_id, :type => String
  field :avatar, :type => String
  field :time_zone, :type => String
  field :tw_access_token, :type => String
  field :fb_access_token, :type => String
  field :created_on, :type => DateTime
  field :updated_on, :type => DateTime
  
  has_many :questions
  has_many :answers
end
