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
  end

  context "edit" do
    before do
      @mentor = Factories::Mentor.create!
      as_mentor(@mentor) do
        get :edit
      end
    end

    it "assigns availabilities for the current mentor" do
      expect(assigns(:availabilities)).to eq(@mentor.availabilities_by_day)
    end
  end

  context "update" do
    context "success" do
      before do
        @mentor = Factories::Mentor.create!
        Time.zone = @mentor.time_zone
        Factories::Availability.create!(mentor: @mentor, year: 2015, month: 1, day: 4, hour: 12)
        Factories::Availability.create!(mentor: @mentor, year: 2015, month: 1, day: 5, hour: 12)
        params = {
          availabilities: {
            sunday: ["10", "12"],
            monday: ["11"],
            tuesday: ["12"],
            wednesday: ["13"],
            thursday: ["14"],
            friday: ["15"],
            saturday: ["16"]
          }
        }
        as_mentor(@mentor) do
          patch :update, params
        end
      end

      it "creates or removes availabilities for the given mentor" do
        Time.zone = @mentor.time_zone
        expect(@mentor.reload.availabilities.map(&:start).map(&:hour)).to eq [12, 10, 11, 12, 13, 14, 15, 16]
        expect(@mentor.reload.availabilities.map(&:start).map(&:wday)).to eq [0, 0, 1, 2, 3, 4, 5, 6]
      end

      it "redirects back to the mentor show page" do
        expect(response).to redirect_to(mentors_show_path(@mentor))
      end

      it "sets a flash notice" do
        expect(flash[:notice]).to_not be_nil
      end
    end

    context "error" do
      before do
        @mentor = Factories::Mentor.create!
        params = {
          availabilities: {
            sunday: ["bad params"]
          }
        }
        as_mentor(@mentor) do
          patch :update, params
        end
      end

      it "sets a flash alert if an error occurs" do
        expect(flash[:alert]).to_not be_nil
      end

      it "redirects back to the edit view" do
        expect(response).to redirect_to(availabilities_edit_path)
      end
    end
  end
end
