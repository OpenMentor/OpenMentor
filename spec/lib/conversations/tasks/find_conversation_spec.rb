require 'spec_helper'
require 'conversations/tasks/find_conversation'

describe Conversations::FindConversation do
  subject { described_class }

  let(:conversation) { Factories::Conversation.create! }
  let(:mentor)       { conversation.mentors.first }
  let(:other_mentor) { Factories::Mentor.create! }

  context "success" do
    before do
      @result = subject.execute(conversation_id: conversation.id.to_s, sender: mentor)
    end

    it "finds the conversation for the given id" do
      expect(@result.conversation).to eq(conversation)
    end

    it "status:success" do
      expect(@result.status).to eq(:success)
    end
  end

  context "failure" do
    it "raises an error" do
      expect { subject.execute(conversation_id: conversation.id.to_s, sender: other_mentor) }.to\
        raise_error(ActionLogic::PresenceError)
    end
  end
end
