module Conversations
  class FindConversation
    include ActionLogic::ActionTask

    validates_before sender: { type: :mentor, presence: true },
                     conversation_id: { type: :string, presence: ->(conversation_id) { !conversation_id.empty? } }

    validates_after conversation: { presence: true }

    def call
      context.conversation = conversation
    end

    private

    def conversation
      Conversation.
        joins(:conversations_mentors).
        where(:conversations => { id: context.conversation_id },
              :conversations_mentors => { :mentor_id => context.sender.id }).
        first
    end
  end
end
