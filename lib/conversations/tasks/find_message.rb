module Conversations
  class FindMessage
    include ActionLogic::ActionTask

    validates_before conversation_id: { type: :string, presence: ->(conversation_id) { !conversation_id.empty? } },
                     message_id: { type: :string, presence: ->(message_id) { !message_id.empty? } }

    validates_after message: { presence: true }

    def call
      context.message = message
    end

    private

    def message
      Message.where(id: context.message_id,
                    conversation_id: context.conversation_id).first
    end
  end
end
