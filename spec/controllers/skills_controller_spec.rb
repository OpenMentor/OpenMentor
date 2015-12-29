require 'spec_helper'

describe SkillsController do

  context "create success" do
    before do
      @name = "Test"
      @result = post :create,  { skill:  { name: @name } }
    end

    it "creates a new skill" do
      skill = Skill.last
      expect(skill.name).to eq(@name)
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to_not be_nil
    end

    it "redirects to root" do
      expect(@result).to redirect_to(root_path)
    end
  end

  context "create error" do
    before do
      @name = "Test"
      Skill.create!(:name => @name)

      @result = post :create, skill: { name: @name }
    end

    it "sets a flash error" do
      expect(flash[:error].messages[:name]).to_not be_nil
    end

    it "redirects to new" do
      expect(@result).to redirect_to(new_skill_path)
    end
  end
end
