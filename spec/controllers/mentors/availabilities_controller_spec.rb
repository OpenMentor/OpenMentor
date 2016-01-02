require 'spec_helper'

describe Mentors::AvailabilitiesController do
  context "index" do
    before do
      @mentor = Factories::Mentor.create!
      as_mentor do
        get :index, id: @mentor.id
      end
    end

    it "assigns the mentor's availabilities" do
      expect(assigns(:availabilities)).to eq(@mentor.availabilities_by_day)
    end

    it "assigns the days" do
      expect(assigns(:days)).to eq(Availability.days.keys)
    end
  end
end
