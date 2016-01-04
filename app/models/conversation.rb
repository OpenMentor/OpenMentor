class Conversation < ActiveRecord::Base
  has_and_belongs_to_many :mentors
  has_many :messages
end
