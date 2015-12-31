class Skill < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  has_many :mentor_skills
  has_many :mentors, through: :mentor_skills

  def self.already_skill?(skill_proposal)
    where(arel_table[:name].matches("#{skill_proposal.name}%")).any?
  end
end
