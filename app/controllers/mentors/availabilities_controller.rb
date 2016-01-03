module Mentors
  class AvailabilitiesController < ApplicationController
    def index
      Time.zone = mentor.time_zone
      @original_availabilities = mentor.availabilities_by_day

      Time.zone = current_mentor.time_zone
      @availabilities = mentor.reload.availabilities_by_day
    end

    private

    def mentor
      @mentor ||= Mentor.find(params[:id])
    end
  end
end
