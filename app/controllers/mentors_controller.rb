class MentorsController < ApplicationController
  before_action :authenticate_mentor!

  def index
    @mentors = Mentor.all
  end

  def show
    @mentor = Mentor.find(params[:id])
  end
end
