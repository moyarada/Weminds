class Answer
  include Mongoid::Document
  field :content, :type => String
  field :source, :type => String
  field :created_on, :type => DateTime
  field :updated_on, :type => DateTime
  
  belongs_to :question
  belongs_to :user
end
