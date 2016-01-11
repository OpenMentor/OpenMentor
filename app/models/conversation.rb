class Conversation < ActiveRecord::Base
  has_and_belongs_to_many :mentors
  has_many :messages

  def most_recent_order
    messages.order(created_at: :desc)
  end

  def unread_count
    messages.where(read_at: nil).count
  end
end
