require 'spec_helper'

describe ConversationsController do
  context "index" do
    before do
      @mentor = Factories::Mentor.create!
      as_mentor(@mentor) do
        get :index
      end
    end

    it "assigns conversations for the current mentor" do
      expect(assigns(:conversations)).to eq([])
    end
  end

  context "new" do
    before do
      @mentor = Factories::Mentor.create!
      @other_mentor = Factories::Mentor.create!
      @other_mentor2 = Factories::Mentor.create!
    end

    it "assigns a receiver" do
      as_mentor(@mentor) do
        get :new, receiver_ids: [@other_mentor.id, @other_mentor2.id]
        expect(assigns(:receivers)).to eq([@other_mentor, @other_mentor2])
      end
    end

    it "assigns an empty array if there are no receivers" do
      as_mentor(@mentor) do
        get :new, receiver_ids: []
        expect(assigns(:receivers)).to eq([])
      end
    end
  end

  context "create" do
    before do
      @mentor = Factories::Mentor.create!
      @other_mentor = Factories::Mentor.create!
      @other_mentor2 = Factories::Mentor.create!
      @subject = "Test Subject"
      @body = "Test body message"
      as_mentor(@mentor) do
        put :create, subject: @subject, body: @body, receiver_ids: [@other_mentor.id, @other_mentor2.id]
      end
    end

    it "creates a new conversation for all mentors involved" do
      expect(@mentor.conversations.count).to eq 1
      expect(@other_mentor.conversations.count).to eq 1
      expect(@other_mentor2.conversations.count).to eq 1
    end

    it "has the correct subject" do
      expect(@mentor.conversations.first.subject).to eq(@subject)
    end

    it "creates the first message from the body params" do
      expect(@mentor.messages.count).to eq(1)
      expect(@mentor.conversations.first.messages.first.body).to eq(@body)
    end
  end
end
