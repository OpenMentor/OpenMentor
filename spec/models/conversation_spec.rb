require 'spec_helper'

describe Conversation do
  let(:conversation) { Factories::Conversation.create! }
  let(:mentor1) { conversation.mentors.first }
  let(:mentor2) { conversation.mentors.last }
  let!(:message1) { Factories::Message.create!(sender: mentor1, receiver: mentor2, conversation: conversation, read_at: Time.current, sent_at: Time.current - 1.hour) }
  let!(:message2) { Factories::Message.create!(sender: mentor2, receiver: mentor1, conversation: conversation, read_at: nil) }

  context "most_recent_order" do
    it "returns messages for a conversation in order of created_at desc" do
      expect(conversation.most_recent_order.map(&:id)).to eq([message2.id, message1.id])
    end
  end

  context "unread_count" do
    it "returns the number of unread messages for a given conversation" do
      expect(conversation.unread_count).to eq(1)
    end
  end
end
