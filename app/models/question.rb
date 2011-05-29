class Question
  include Mongoid::Document
  field :content, :type => String
  field :source, :type => String
  field :created_on, :type => DateTime
  field :updated_on, :type => DateTime
  field :post_on, :type => Array
  field :post_statuses, :type => Array
  
  belongs_to :user
  has_many :questions  
end
