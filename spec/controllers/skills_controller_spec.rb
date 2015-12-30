require 'spec_helper'

describe SkillsController do
  context "new" do
    it "allows admin to access new skill form" do
      as_admin do
        get :new
        expect(response.status).to eq(200)
      end
    end

    it "does not allow mentors to access new skill form" do
      as_mentor do
        expect { get :new }.to raise_error(error_404)
      end
    end
  end

  context "index" do
    it "allows admins or mentors to access" do
      as_admin do
        get :index
        expect(response.status).to eq(200)
      end

      as_mentor do
        get :index
        expect(response.status).to eq(200)
      end
    end
  end

  context "admin create success" do
    before do
      as_admin do
        @name = "Test"
        @result = post :create,  { skill:  { name: @name } }
      end
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

  context "mentor create" do
    it "mentors cannot create skills" do
      as_mentor do
        @name = "Test"
        expect { post :create,  { skill:  { name: @name } } }.to raise_error(error_404)
      end
    end
  end

  context "admin create error" do
    before do
      as_admin do
        @name = "Test"
        Factories::Skill.create!(name: @name)

        @result = post :create, skill: { name: @name.downcase }
      end
    end

    it "sets a flash error" do
      expect(flash[:error].messages[:name]).to_not be_nil
    end

    it "redirects to new" do
      expect(@result).to redirect_to(new_skill_path)
    end
  end
end
