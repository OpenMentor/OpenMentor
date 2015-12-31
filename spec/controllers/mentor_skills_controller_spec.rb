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

  context "update mentor skill success" do
    before do
      @new_skill = Factories::Skill.create!
      as_mentor(mentor) do
        patch :update, skills: [@new_skill.id, skill.id]
      end
    end

    it "updates mentor skills" do
      expect(mentor.skills.map(&:id)).to eq [@new_skill.id, skill.id]
    end

    it "redirects to the mentor skill index" do
      expect(response).to redirect_to(mentor_skills_path)
    end

    it "sets a success message" do
      expect(flash[:notice]).to_not be_nil
    end
  end

  context "update mentor skills does not duplicate existing mentor skills" do
    before do
      @new_skill = Factories::Skill.create!
      as_mentor(mentor) do
        patch :update, skills: [@new_skill.id, skill.id]
      end
    end

    it "ignores existing skill ids that already belogn to the mentor" do
      expect(mentor.skills).to eq [@new_skill, skill]
    end
  end

  context "update mentor skills removes skills no longer valid for the mentor" do
    before do
      @new_skill = Factories::Skill.create!
      as_mentor(mentor) do
        patch :update, skills: [@new_skill.id]
      end
    end

    it "removes original skill" do
      expect(mentor.skills).to eq [@new_skill]
    end
  end

  context "update mentor skill error" do
    before do
      as_mentor(mentor) do
        patch :update, skills: ["alert"]
      end
    end

    it "sets an alert flash message" do
      expect(flash[:alert]).to_not be_nil
    end

    it "redirects back to the edit mentor skill page" do
      expect(response).to redirect_to(mentor_skills_edit_path)
    end
  end

  context "edit" do
    before do
      as_mentor(mentor) do
        get :edit
      end
    end

    it "assigns existing mentor skills" do
      expect(assigns(:mentor_skills)).to eq mentor.skills
    end

    it "assigns all skills" do
      expect(assigns(:skills)).to eq(Skill.all - mentor.skills)
    end
  end
end
