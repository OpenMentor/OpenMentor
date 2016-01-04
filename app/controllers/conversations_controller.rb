class ConversationsController < ApplicationController
  def index
    @conversations = current_mentor.conversations
  end

  def new
    @receivers = Mentor.find(params[:receiver_ids])
  end

  def create
    conversation = Conversation.create!(subject: params[:subject],
                                        mentors: (Mentor.find(params[:receiver_ids]) << current_mentor))

    Message.create!(sender_id: current_mentor.id,
                    body: params[:body],
                    conversation: conversation,
                    sent_at: Time.current)

    redirect_to action: "index"
  end

  def show
    @conversation = Conversation.find(params[:id])
  end
end
