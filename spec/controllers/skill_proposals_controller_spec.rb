require 'spec_helper'

describe SkillProposalsController do
  let(:mentor) { Factories::Mentor.create! }

  context "mentor skill proposal success" do
    before do
      as_mentor do
        @name = "Test"
        @result = post :create,  { skill_proposal:  { name: @name } }
      end
    end

    it "creates a new proposed skill" do
      skill_proposal = SkillProposal.last
      expect(skill_proposal.name).to eq(@name)
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to_not be_nil
    end

    it "redirects to root" do
      expect(@result).to redirect_to(root_path)
    end
  end

  context "mentor skill proposal validates name uniqueness" do
    before do
      as_mentor(mentor) do
        @name = "Test"
        Factories::SkillProposal.create!(name: @name, proposed_by: mentor.id)

        @result = post :create, skill_proposal: { name: @name }
      end
    end

    it "sets a flash error" do
      expect(flash[:alert].messages[:name]).to_not be_nil
    end

    it "redirects to new" do
      expect(@result).to redirect_to(skill_proposal_new_path)
    end
  end

  context "mentor skill proposal is already a skill error" do
    before do
      @name = "Test2"
      Factories::SkillProposal.create!(name: @name, proposed_by: mentor.id)

      as_mentor do
        @result = post :create, skill_proposal: { name: @name.downcase }
      end
    end

    it "sets a flash error" do
      expect(flash[:alert].messages[:name]).to_not be_nil
    end

    it "redirects to new" do
      expect(@result).to redirect_to(skill_proposal_new_path)
    end
  end

  context "index" do
    before do
      other_mentor = Factories::Mentor.create!
      as_mentor(mentor) do
        @skill_proposal1 = Factories::SkillProposal.create!(proposed_by: mentor.id)
        @skill_proposal2 = Factories::SkillProposal.create!(proposed_by: mentor.id)
        @other_skill = Factories::SkillProposal.create!(proposed_by: other_mentor.id)
        @response = get :index
      end
    end

    it "lists all skills proposed by the current mentor" do
      expect(assigns(:skill_proposals)).to eq [@skill_proposal1, @skill_proposal2]
    end

    it "does not show skills proposed by other mentors" do
      expect(assigns(:skill_proposals)).to_not include(@other_skill)
    end
  end
end
