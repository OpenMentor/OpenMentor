class SkillsController < ApplicationController
  before_action :validate_admin!, except: [:index]

  def new
    @skill = Skill.new
  end

  def create
    if name_already_exists?
      flash[:error] = custom_error skill, { name: invalid_skill_message }
      redirect_to action: "new"
    elsif skill.save
      flash[:notice] = success_skill_message
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

  def name_already_exists?
    Skill.already_skill?(skill)
  end

  def invalid_skill_message
    "The #{skill.name} skill already exists!"
  end

  def success_skill_message
    "#{skill.name} added successfully!"
  end

  def skill
    @skill ||= Skill.new(skill_params)
  end

  def skill_params
    params.require(:skill).permit(:name)
  end
end
