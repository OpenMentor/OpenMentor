module Factories
  class Availability
    def self.create!(options = {})
      build(options).tap { |availability| availability.save! }
    end

    def self.build(options = {})
      mentor = options.fetch(:mentor) { Mentor.create! }
      Time.zone = mentor.time_zone

      now     = Time.now
      year    = options.fetch(:year, now.year)
      month   = options.fetch(:month, now.month)
      day     = options.fetch(:day, now.day)
      hour    = options.fetch(:hour, [*0..23].sample)
      minutes = options.fetch(:minutes, 0)
      seconds = options.fetch(:seconds, 0)

      start = Time.zone.local(year, month, day, hour, minutes, seconds)

      ::Availability.new(
        mentor: mentor,
        start: start
      )
    end
  end
end
