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
        as_mentor(mentor) do
          patch :update, mentor: { name: @name }
        end
      end

      it "sets a success flash message" do
        expect(flash[:notice]).to_not be_nil
      end

      it "updates the mentor" do
        expect(mentor.reload.name).to eq(@name)
      end

      it "redirects back to the mentor show page" do
        expect(response).to redirect_to(mentor_show_path(mentor))
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
        expect(response).to redirect_to(mentor_edit_path)
      end
    end
  end
end
