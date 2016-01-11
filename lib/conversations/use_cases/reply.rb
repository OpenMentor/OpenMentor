require 'conversations/tasks/create_message'
require 'conversations/tasks/find_conversation'
require 'conversations/tasks/find_message'

module Conversations
  class Reply
    include ActionLogic::ActionUseCase

    validates_before id: { type: :string, presence: ->(id) { !id.empty? } },
                     current_mentor: { type: :mentor, presence: true },
                     message_id: { type: :string, presence: ->(id) { !id.empty? } },
                     body: { type: :string, presence: ->(body) { !body.empty? } }

    def call
      context.sender = context.current_mentor
      context.conversation_id = context.id
    end

    def tasks
      [
        Conversations::FindConversation,
        Conversations::FindMessage,
        Conversations::CreateMessage
      ]
    end
  end
end
