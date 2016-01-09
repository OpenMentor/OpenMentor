class ConversationsController < ApplicationController
  def index
    @conversations = current_mentor.conversations
  end

  def new
    # Require an explicit receiver for v1.
    # Revisit so multiple receivers can be added as part of new message creation.
    receiver
  end

  def create
    conversation.save
    message.save
    flash[:notice] = "Your message delivered successfully"
    redirect_to action: "index"
  end

  def show
    @conversation ||= Conversation.find(params[:id])
  end

  private

  def receiver
    render_404 unless params[:receiver_id]
    @receiver ||= Mentor.find(params[:receiver_id])
  end

  def conversation
    @conversation ||= Conversation.new(
      subject: params[:subject],
      mentors: [receiver, current_mentor]
    )
  end

  def message
    @message ||= Message.new(
      sender_id: current_mentor.id,
      body: params[:body],
      conversation: conversation,
      sent_at: Time.current
    )
  end
end
