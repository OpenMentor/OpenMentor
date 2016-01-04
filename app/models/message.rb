class Message < ActiveRecord::Base
  belongs_to :conversation

  belongs_to :mentor, foreign_key: 'sender_id'
end
