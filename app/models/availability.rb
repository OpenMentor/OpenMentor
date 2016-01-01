class Availability < ActiveRecord::Base
  enum day: {
    sunday: 0,
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6
  }

  belongs_to :mentor

  validates :mentor_id, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :day, presence: true

  scope :for_mentor, ->(mentor) { where(mentor: mentor) }
end
