module Factories
  class MentorSkill
    def self.create!(options = {})
      build(options).tap { |mentor_skill| mentor_skill.save! }
    end

    def self.build(options = {})
      ::MentorSkill.new(
        skill: options.fetch(:skill) { Skill.create! },
        mentor: options.fetch(:mentor) { Mentor.create! }
      )
    end
  end
end
