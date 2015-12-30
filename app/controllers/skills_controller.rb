class SkillsController < ApplicationController
  before_action :validate_admin!, except: [:index]

  def new
    @skill = Skill.new
  end

  def create
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

  def skill
    @skill ||= Skill.new(skill_params)
  end

  def skill_params
    params.require(:skill).permit(:name)
  end
end
