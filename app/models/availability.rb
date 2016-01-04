class Availability < ActiveRecord::Base
  WDAYS_COLUMNS = {
    su: "sunday",
    mo: "monday",
    tu: "tuesday",
    we: "wednesday",
    th: "thursday",
    fr: "friday",
    sa: "saturday"
  }

  WDAYS = {
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
  validates :duration, presence: true

  scope :for_mentor, ->(mentor) { where(mentor: mentor) }
end
