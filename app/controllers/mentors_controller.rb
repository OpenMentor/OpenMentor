class MentorsController < ApplicationController
  def index
    @mentors = Mentor.all
  end
end
