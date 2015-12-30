require 'spec_helper'

describe MentorsController do
  context "show" do
    it "finds a mentor" do
      mentor = Factories::Mentor.create!
      as_mentor do
        get :show, id: mentor.id
        expect(assigns(:mentor)).to eq(mentor)
      end
    end
  end
end
