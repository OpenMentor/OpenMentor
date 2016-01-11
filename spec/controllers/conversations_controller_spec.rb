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
    end

    it "assigns a receiver" do
      as_mentor(@mentor) do
        get :new, receiver_id: @other_mentor.id
        expect(assigns(:receiver)).to eq(@other_mentor)
      end
    end

    it "returns a 404 if no receivers are specified" do
      as_mentor(@mentor) do
        expect { get :new, receiver_id: nil }.to raise_error(error_404)
      end
    end
  end

  context "create" do
    context "success" do
      before do
        @mentor1 = Factories::Mentor.create!
        @mentor2 = Factories::Mentor.create!
        @subject = "Test Subject"
        @body = "Test body message"
        as_mentor(@mentor1) do
          put :create, subject: @subject, body: @body, receiver_id: @mentor2.id
        end
      end

      it "creates a new conversation for all mentors involved" do
        expect(@mentor1.conversations.count).to eq 1
        expect(@mentor2.conversations.count).to eq 1
      end

      it "has the correct subject" do
        expect(@mentor1.conversations.first.subject).to eq(@subject)
      end

      it "creates the first message from the body params" do
        expect(@mentor1.messages.count).to eq(1)
        expect(@mentor1.conversations.first.messages.first.body).to eq(@body)
      end

      it "sets a flash notice" do
        expect(flash[:notice]).to_not be_nil
      end
    end
  end

  context "reply" do
    context "success" do
      before do
        @conversation = Factories::Conversation.create!
        @mentor1, @mentor2 = @conversation.mentors
        @message1 = Factories::Message.create!(sender: @mentor2, receiver: @mentor2, conversation: @conversation)
        @body = "Reply body"

        as_mentor(@mentor1) do
          patch :reply, conversation: { id: @conversation.id, message_id: @message1.id, body: @body }
        end

        @conversation.reload
      end

      it "adds the reply as a message to the conversation" do
        expect(@conversation.messages.last.body).to eq(@body)
      end

      it "sets a flash notice" do
        expect(flash[:notice]).to_not be_nil
      end

      it "redirects to the conversation show page" do
        expect(response).to redirect_to(conversations_show_path(@conversation))
      end
    end

    context "error" do
      before do
        @conversation = Factories::Conversation.create!
        @mentor1, @mentor2 = @conversation.mentors
        @other_mentor = Factories::Mentor.create!
        @message1 = Factories::Message.create!(sender: @mentor1, receiver: @mentor2, conversation: @conversation)
        @body = "Reply body"
        as_mentor(@other_mentor) do
          patch :reply, conversation: { id: @conversation.id, message_id: @message1.id, body: @body }
        end
      end

      it "redirects to conversations index" do
        expect(response).to redirect_to(conversations_path)
      end
    end
  end
end
