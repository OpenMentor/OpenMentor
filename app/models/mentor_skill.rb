class MentorSkill < ActiveRecord::Base
  belongs_to :mentor
  belongs_to :skill
end
