require 'spec_helper'
require 'conversations/tasks/find_message'

describe Conversations::FindMessage do
  subject { described_class }

  let(:conversation)  { Factories::Conversation.create! }
  let(:mentor)        { conversation.mentors.first }
  let(:message)       { Factories::Message.create!(sender: mentor, conversation: conversation) }
  let(:other_message) { Factories::Message.create! }

  context "success" do
    before do
      @result = subject.execute(message_id: message.id.to_s, conversation_id: conversation.id.to_s)
    end

    it "finds the message for the given id" do
      expect(@result.message).to eq(message)
    end

    it "status:success" do
      expect(@result.status).to eq(:success)
    end
  end

  context "failure" do
    it "raises an error" do
      expect { subject.execute(message_id: other_message.id.to_s, conversation_id: conversation.id.to_s) }.to\
        raise_error(ActionLogic::PresenceError)
    end
  end
end

