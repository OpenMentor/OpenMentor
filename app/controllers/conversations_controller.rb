require 'conversations/use_cases/reply'

class ConversationsController < ApplicationController
  def index
    @conversations = current_mentor.conversations
  end

  def new
    # Require an explicit receiver for v1.
    # Revisit so multiple receivers can be added as part of new message creation.
    receiver
  end

  def reply
    result = Conversations::Reply.execute(reply_params)
    flash[:notice] = "Your message delivered successfully"
    redirect_to conversations_show_path(result.conversation)
  rescue
    flash[:alert] = "Something went wrong delivering your message, please try again"
    redirect_to conversations_path
  end

  def create
    # TODO: Error handling around conversation / message creation
    conversation.save
    message.save
    flash[:notice] = "Your message delivered successfully"
    redirect_to action: "index"
  end

  def show
    @conversation ||= Conversation.find(params[:id])
  end

  private

  def reply_params
    params.require(:conversation).permit(:id, :message_id, :body).merge(current_mentor: current_mentor)
  end

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
