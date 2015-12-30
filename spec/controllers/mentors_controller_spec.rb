require 'spec_helper'

describe MentorsController do
  context "index" do
    it "returns all mentors that are not the current mentor" do
      mentor1 = Factories::Mentor.create!
      mentor2 = Factories::Mentor.create!
      mentor3 = Factories::Mentor.create!
      as_mentor do
        get :index
        expect(assigns(:mentors).map(&:id)).to eq [mentor1.id, mentor2.id, mentor3.id]
      end
    end
  end

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
