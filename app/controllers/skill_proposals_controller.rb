class SkillProposalsController < ApplicationController

  def new
    @skill_proposal = SkillProposal.new
  end

  def create
    if name_already_exists?
      flash[:error] = custom_error skill_proposal, { name: invalid_proposal_message }
      redirect_to action: "new"
    elsif skill_proposal.save
      flash[:notice] = success_proposal_message
      redirect_to root_path
    else
      flash[:error] = skill_proposal.errors
      redirect_to action: "new"
    end
  end

  def index
    @skill_proposals = SkillProposal.where(proposed_by: current_mentor.id)
  end

  private

  def skill_proposal
    @skill_proposal ||= SkillProposal.new(skill_proposal_params)
  end

  def skill_proposal_params
    params.
      require(:skill_proposal).
      permit(:name).
      merge(proposed_by: current_mentor.id)
  end

  def name_already_exists?
    already_skill? || already_skill_proposal?
  end

  def already_skill?
    Skill.already_skill?(skill_proposal)
  end

  def already_skill_proposal?
    SkillProposal.already_skill_proposal?(skill_proposal)
  end

  def success_proposal_message
    "Thank you for proposing #{skill_proposal.name} as a skill! Your proposal will be reviewed."
  end

  def invalid_proposal_message
    "Thank you for your proposal, but #{skill_proposal.name} already exists as a skill!"
  end
end
