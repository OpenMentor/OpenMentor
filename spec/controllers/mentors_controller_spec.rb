require 'spec_helper'

describe MentorsController do
  let(:mentor) { Factories::Mentor.create! }

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
      as_mentor do
        get :show, id: mentor.id
        expect(assigns(:mentor)).to eq(mentor)
      end
    end
  end

  context "edit" do
    it "sets the correct mentor" do
      as_mentor(mentor) do
        get :edit
        expect(assigns(:mentor)).to eq(mentor)
      end
    end

    it "does not allow mentors to edit other mentors" do
      other_mentor = Factories::Mentor.create!
      as_mentor(mentor) do
        get :edit, id: other_mentor.id
        expect(assigns(:mentor)).to eq(mentor)
      end
    end
  end

  context "update" do
    context "successful update" do
      before do
        @name = "New Name"
        @about = "New About"
        @time_zone = "Hawaii"
        as_mentor(mentor) do
          patch :update, mentor: { name: @name, about: @about, profile_picture: @profile_picture, time_zone: @time_zone }
        end
      end

      it "sets a success flash message" do
        expect(flash[:notice]).to_not be_nil
      end

      it "updates the mentor" do
        expect(mentor.reload.name).to eq(@name)
        expect(mentor.about).to eq(@about)
        expect(mentor.time_zone).to eq(@time_zone)
      end

      it "redirects back to the mentor show page" do
        expect(response).to redirect_to(mentors_show_path(mentor))
      end
    end

    context "error" do
      before do
        @name = nil
        as_mentor(mentor) do
          patch :update, mentor: { name: @name }
        end
      end

      it "sets an error flash message" do
        expect(flash[:alert]).to_not be_nil
      end

      it "redirects to the edit page" do
        expect(response).to redirect_to(mentors_edit_path)
      end
    end
  end

  context "search" do
    before do
      @name1   = "Stephanie Briones"
      @name2   = "Steven Colbert"
      @name3   = "Barack Obama"
      @email1  = "stephanie@briones.com"
      @email2  = "steven@colbert.com"
      @email3  = "president@whitehouse.com"
      @mentor1 = Factories::Mentor.create!(name: @name1, email: @email1)
      @mentor2 = Factories::Mentor.create!(name: @name2, email: @email2)
      @mentor3 = Factories::Mentor.create!(name: @name3, email: @email3)
    end

    it "returns a json formatted name and email address when a successful match is made via name" do
      as_mentor do
        get :search, search: "Stephanie", format: :json
        expect(response.body).to eq(JSON.generate(@mentor1.id => {name: @name1, email: @email1}))
      end
    end

    it "returns a json formatted collection of names and email addresses when a search query matches against multiple mentors" do
      as_mentor do
        get :search, search: "Ste", format: :json
        expect(response.body).to eq(JSON.generate(@mentor1.id => {name: @name1, email: @email1},
                                                  @mentor2.id => {name: @name2, email: @email2}))
      end
    end

    it "returns a mentor when search string only matches against an email address" do
      as_mentor do
        get :search, search: "pres", format: :json
        expect(response.body).to eq(JSON.generate(@mentor3.id => {name: @mentor3.name, email: @mentor3.email}))
      end
    end
  end
end
