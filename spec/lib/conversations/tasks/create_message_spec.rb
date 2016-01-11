require 'spec_helper'
require 'conversations/tasks/create_message'

describe Conversations::CreateMessage do
  subject { described_class }

  let(:conversation) { Factories::Conversation.create! }
  let(:mentor) { conversation.mentors.first }
  let(:body) { "Message body" }

  context "success" do
    before do
      @result = subject.execute(sender: mentor, conversation: conversation, body: body)
    end

    it "sets a new message on the context" do
      expect(@result.message).to_not be_nil
      expect(@result.message.body).to eq(body)
      expect(@result.message.sender_id).to eq(mentor.id)
    end

    it "status:success" do
      expect(@result.status).to eq(:success)
    end
  end
end
