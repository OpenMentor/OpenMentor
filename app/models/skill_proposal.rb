class SkillProposal < ActiveRecord::Base
  belongs_to :mentor, foreign_key: 'proposed_by'
  belongs_to :mentor, foreign_key: 'reviewed_by'

  validates :name, presence: true, uniqueness: true

  def self.already_skill_proposal?(skill_proposal)
    where(arel_table[:name].matches("#{skill_proposal.name}%")).any?
  end
end
