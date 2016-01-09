class ConversationsController < ApplicationController
  def index
    @conversations = current_mentor.conversations
  end

  def new
    # Require an explicit receiver for v1.
    # Revisit so receivers can be added as part
    # of new message creation.
    render_404 unless receivers.any?
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

  private

  def receivers
    receiver_ids = params[:receiver_ids] || []
    @receivers ||= Mentor.find(receiver_ids)
  end
end
