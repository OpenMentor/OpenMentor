class Skill < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  def self.already_skill?(skill_proposal)
    where(arel_table[:name].matches("#{skill_proposal.name}%")).any?
  end
end
