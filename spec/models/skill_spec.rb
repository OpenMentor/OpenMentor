require 'spec_helper'

describe Skill do
  describe ".already_skill?" do
    before do
      @skill = Factories::Skill.create!
    end

    it "returns true if a skill for the given name already exists (case insensitive)" do
      name = @skill.name.downcase
      skill = Skill.new(name: name)
      expect(Skill.already_skill?(skill)).to be_truthy
    end

    it "returns false if a skill for the given name doesn't exist" do
      skill = Skill.new(name: "New Skill")
      expect(Skill.already_skill?(skill)).to be_falsey
    end
  end
end
