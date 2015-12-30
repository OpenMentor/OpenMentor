class MentorsController < ApplicationController
  before_action :authenticate_mentor!

  def index
    @mentors = Mentor.where.not(id: current_mentor.id)
  end

  def show
    @mentor = Mentor.find(params[:id])
  end
end
