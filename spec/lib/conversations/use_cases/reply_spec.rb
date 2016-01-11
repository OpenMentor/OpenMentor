require 'spec_helper'
require 'conversations/use_cases/reply'

describe Conversations::Reply do
  subject { described_class }

  let(:conversation) { Factories::Conversation.create! }
  let(:mentor1) { conversation.mentors.first }
  let(:mentor2) { conversation.mentors.last }
  let(:unknown_mentor) { Factories::Mentor.create! }
  let(:body) { "Reply body" }
  let(:message1) { Factories::Message.create!(sender: mentor1, receiver: mentor2, conversation: conversation, body: body) }
  let(:success_params) { { id: conversation.id.to_s, current_mentor: mentor2, message_id: message1.id.to_s, body: body } }
  let(:error_params) { { id: conversation.id.to_s, current_mentor: unknown_mentor, message_id: message1.id.to_s, body: body } }

  context "success" do
    before do
      @result = subject.execute(success_params)
    end

    it "creates a reply message" do
      expect(conversation.reload.messages.count).to eq(2)
      expect(conversation.messages.last.body).to eq(body)
      expect(conversation.messages.last.sender_id).to eq(mentor2.id)
    end

    it "returns a success status" do
      expect(@result.status).to eq(:success)
    end

    it "returns a conversation" do
      expect(@result.conversation).to_not be_nil
    end
  end

  context "error" do
    it "raises error" do
      expect { subject.execute(error_params) }.to raise_error(ActionLogic::PresenceError)
    end
  end
end
