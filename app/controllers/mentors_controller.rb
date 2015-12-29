class MentorsController < ApplicationController
  before_action :authenticate_mentor!

  def index
    @mentors = Mentor.all
  end
end
