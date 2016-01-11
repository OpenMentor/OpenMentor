module Conversations
  class CreateMessage
    include ActionLogic::ActionTask

    validates_before sender: { type: :mentor, presence: true },
                     conversation: { type: :conversation, presence: true },
                     body: { type: :string, presence: ->(body) { !body.empty? } }

    validates_after message: { presence: true }

    def call
      context.message = Message.create(
        sender_id: context.sender.id,
        conversation: context.conversation,
        body: context.body,
        sent_at: Time.current
      )
    end
  end
end
