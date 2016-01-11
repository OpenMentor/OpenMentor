module Factories
  class Message
    def self.create!(options = {})
      build(options).tap { |message| message.save! }
    end

    def self.build(options = {})
      sender = options.fetch(:sender) { Mentor.create! }
      receiver = options.fetch(:receiver) { Mentor.create! }

      ::Message.new(
        sender_id: sender.id,
        body: options.fetch(:body, "Message body"),
        conversation: options.fetch(:conversation) { Conversation.create!(mentors: [sender, receiver]) },
        sent_at: options.fetch(:sent_at, Time.current),
        read_at: options.fetch(:read_at, Time.current)
      )
    end
  end
end
