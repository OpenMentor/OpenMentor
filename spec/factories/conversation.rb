module Factories
  class Conversation
    def self.create!(options = {})
      build(options).tap { |conversation| conversation.save! }
    end

    def self.build(options = {})
      mentors = options.fetch(:mentors) { [Mentor.create!, Mentor.create!] }

      ::Conversation.new(
        subject: options.fetch(:subject, "Test Subject"),
        mentors: mentors
      )
    end
  end
end
