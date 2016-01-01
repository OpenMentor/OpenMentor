module Mentors
  class AvailabilitiesController < ApplicationController
    def index
      @days = Availability.days.keys
      @availabilities = current_mentor.availabilities
    end

    private

    def mentor
      Mentor.find(params[:id])
    end
  end
end
