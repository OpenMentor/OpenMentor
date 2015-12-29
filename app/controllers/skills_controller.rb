class SkillsController < ApplicationController
  def new
    @skill = Skill.new
  end

  def create
    skill = Skill.new(skill_params)

    if skill.save
      flash[:notice] = "#{skill.name} skill added successfully!"
      redirect_to root_path
    else
      flash[:error] = skill.errors
      redirect_to action: "new"
    end
  end

  def index
    @skills = Skill.all
  end

  private

  def skill_params
    params.require(:skill).permit(:name)
  end
end
