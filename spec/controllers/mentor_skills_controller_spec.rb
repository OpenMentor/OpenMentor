require 'spec_helper'

describe MentorSkillsController do
  let(:mentor_skill) { Factories::MentorSkill.create! }
  let(:mentor) { mentor_skill.mentor }
  let(:skill) { mentor_skill.skill }

  context "index" do
    it "assigns the skills associated with the given mentor" do
      as_mentor(mentor) do
        get :index
        expect(assigns(:mentor_skills)).to eq [skill]
      end
    end
  end

  context "create mentor skill success" do
    before do
      @other_skill = Factories::Skill.create!
      as_mentor(mentor) do
        post :create, skill: { id: @other_skill.id }
      end
    end

    it "creates a new mentor skill" do
      mentor_skill = MentorSkill.where(mentor_id: mentor.id, skill_id: @other_skill.id).first

      expect(mentor_skill).to_not be_nil
    end

  end

  context "create mentor skill error" do
  end

  context "edit" do
  end

  context "update" do
  end
end
