require 'securerandom'

module Factories
  class SkillProposal
    def self.create!(options = {})
      build(options).tap { |skill_proposal| skill_proposal.save! }
    end

    def self.build(options = {})
      ::SkillProposal.new(
        name: options.fetch(:name, SecureRandom.hex(10)),
        proposed_by: options.fetch(:proposed_by) { Mentor.create!.id }
      )
    end
  end
end
