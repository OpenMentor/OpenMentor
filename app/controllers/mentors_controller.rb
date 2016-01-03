class MentorsController < ApplicationController

  def index
    @mentors = Mentor.where.not(id: current_mentor.id)
    @skill_names = Skill.all.map(&:name)
  end

  def show
    @mentor = Mentor.find(params[:id])
    @availabilities = @mentor.availabilities_by_day
  end

  def edit
    @mentor = current_mentor
  end

  def update
    if current_mentor.update(member_params)
      flash[:notice] = success_update_message
      redirect_to mentor_show_path(current_mentor)
    else
      flash[:alert] = current_mentor.errors.full_messages
      redirect_to action: "edit"
    end
  end

  private

  def success_update_message
    "Profile updated successfully!"
  end

  def member_params
    params.
      require(:mentor).
      permit(:name, :profile_picture, :time_zone)
  end
end
