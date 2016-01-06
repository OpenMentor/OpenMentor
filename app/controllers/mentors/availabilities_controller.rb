module Mentors
  class AvailabilitiesController < ApplicationController
    def index
      @availabilities = mentor.availabilities_by_day
    end

    def edit
      @availabilities = current_mentor.availabilities_by_day
    end

    def update
      remove_old_availabilities!
      create_new_availabilities!
      flash[:notice] = update_success_message
      redirect_to mentors_show_path(current_mentor)
    rescue
      flash[:alert] = update_error_message
      redirect_to action: "edit"
    end

    private

    def mentor
      @mentor ||= Mentor.find(params[:id])
    end

    def availability_params
      params.require(:availabilities).permit(
        sunday: [],
        monday: [],
        tuesday: [],
        wednesday: [],
        thursday: [],
        friday: [],
        saturday: [])
    end

    def update_success_message
      "Availability successfully updated"
    end

    def update_error_message
      "Something went wrong updating your availability, please try again"
    end

    def canonical_dates
      {
        :sunday => 4,
        :monday => 5,
        :tuesday => 6,
        :wednesday => 7,
        :thursday => 8,
        :friday => 9,
        :saturday => 10
      }
    end

    def day_for(day)
      canonical_dates[day.to_sym]
    end

    def remove_old_availabilities!
      availabilities_by_day = current_mentor.availabilities_by_day

      old_availabilities = current_mentor.availabilities.select do |availability|
        day = canonical_dates.invert[availability.start.day]
        hour = availability.start.hour

        availability_params[day].nil? || !availability_params[day].include?(hour.to_s)
      end

      old_availabilities.each do |availability|
        availability.destroy
      end
    end

    def create_new_availabilities!
      availabilities_by_day = current_mentor.availabilities_by_day

      start_times = availability_params.each_with_object([]) do |(day, hours), collection|
        hours.each do |hour|
          raise unless valid_hour?(hour)
          collection << Time.zone.local(2015, 1, day_for(day), hour, 0, 0)
        end
      end

      start_times = start_times.reject do |start_time|
        weekday = canonical_dates.invert[start_time.day]
        hour = start_time.hour

        availabilities_by_day[weekday] && availabilities_by_day[weekday].include?(hour)
      end

      start_times.each do |start_time|
        Availability.create!(mentor: current_mentor, start: start_time)
      end
    end

    def valid_hour?(hour)
      hour.to_i && hour.to_i > 0
    end
  end
end
