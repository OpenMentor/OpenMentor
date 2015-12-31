class MentorSkillsController < ApplicationController

  def index
    @mentor_skills = current_mentor.skills
  end

  def edit
    @mentor_skills = current_mentor.skills
    @skills = Skill.all - @mentor_skills
  end

  def create
    MentorSkill.create!(skill_id: mentor_skill_params[:id],
                        mentor_id: current_mentor.id)
    redirect_to mentor_skills_path
  end

  def update
  end

  private

  def mentor_skill_params
    params.require(:skill).permit(:id)
  end
end
