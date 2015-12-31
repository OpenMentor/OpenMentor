class MentorSkillsController < ApplicationController

  def edit
    @mentor_skills = current_mentor.skills
    @skills = Skill.all - @mentor_skills
  end

  def update
    begin
      create_new_mentor_skills!
      remove_old_mentor_skills!
      flash[:notice] = update_success_message
      redirect_to mentor_show_path(current_mentor)
    rescue
      flash[:alert] = update_error_message
      redirect_to action: "edit"
    end
  end

  private

  def update_success_message
    "Your skills updated successfully!"
  end

  def update_error_message
    "Something went wrong updating your skills, please try agai, please try again"
  end

  def create_new_mentor_skills!
    new_skills.each do |skill|
      MentorSkill.create!(skill: skill, mentor: current_mentor)
    end
  end

  def remove_old_mentor_skills!
    old_mentor_skills.each do |mentor_skill|
      mentor_skill.destroy
    end
  end

  def new_skills
    Skill.find(new_mentor_skill_ids)
  end

  def old_mentor_skills
    MentorSkill.
      where(mentor: current_mentor).
      where(skill_id: old_mentor_skill_ids)
  end

  def new_mentor_skill_ids
    params.require(:skills).map(&:to_i) - current_mentor.skills.pluck(:id)
  end

  def old_mentor_skill_ids
    current_mentor.skills.pluck(:id) - params.require(:skills).map(&:to_i)
  end
end
