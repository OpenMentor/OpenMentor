module Mentors
  class AvailabilitiesController < ApplicationController
    def index
      @days = Availability.days.keys
      @availabilities = mentor.availabilities_by_day
    end

    private

    def mentor
      @mentor ||= Mentor.find(params[:id])
    end
  end
end
