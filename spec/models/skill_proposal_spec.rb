require 'spec_helper'

describe SkillProposal do
  describe ".already_skill?" do
    before do
      @skill_proposal = Factories::SkillProposal.create!
    end

    it "returns true if a skill proposal for the given name already exists (case insensitive)" do
      name = @skill_proposal.name.downcase
      skill_proposal = SkillProposal.new(name: name)
      expect(SkillProposal.already_skill_proposal?(skill_proposal)).to be_truthy
    end

    it "returns false if a skill proposal for the given name doesn't exist" do
      skill_proposal = SkillProposal.new(name: "New Skill Proposal")
      expect(SkillProposal.already_skill_proposal?(skill_proposal)).to be_falsey
    end
  end
end
