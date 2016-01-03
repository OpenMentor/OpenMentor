require 'spec_helper'

describe Mentor do
  context "#availabilites_by_day" do
    before do
      # Creates a mentor with the Pacific time zone.
      @PDT_mentor = Factories::Mentor.create!(time_zone: "Pacific Time (US & Canada)")

      # Creates availabilities for the mentor with the mentor's time zone for the following days:
      # Sunday
      availability1 = Factories::Availability.create!(mentor: @PDT_mentor, year: 2015, month: 1, day: 4, hour: 12)
      # Monday
      availability2 = Factories::Availability.create!(mentor: @PDT_mentor, year: 2015, month: 1, day: 5, hour: 12)
      # Tuesday
      availability3 = Factories::Availability.create!(mentor: @PDT_mentor, year: 2015, month: 1, day: 6, hour: 12)
      availability4 = Factories::Availability.create!(mentor: @PDT_mentor, year: 2015, month: 1, day: 6, hour: 15)
      # Wednesday (11 pm Pacific Time crosses the date line and is 1 am Central Time Thursday)
      availability5 = Factories::Availability.create!(mentor: @PDT_mentor, year: 2015, month: 1, day: 7, hour: 23)
    end

    it "returns a hash structured like { day: [start_hour..end_hour] }" do
      CDT_mentor = Factories::Mentor.create!(time_zone: "Central Time (US & Canada)")
      Time.zone = "Central Time (US & Canada)"

      # PDT_mentor availabilties are converted from Pacific Time to the correct
      # time zone of the mentor viewing the availabilities.
      # In this case, the CDT_mentor would expect to see the PDT_mentor's availabilities
      # listed in Central Time.
      #
      # These asserts verify that time zone conversion is occuring correctly
      # depending on the time zone of the mentor viewing another mentor's
      # availability.
      #
      # A potential gotcha is when PDT_mentor's availability starts at 11 pm on any given day.
      # 11 pm Pacific Time will spill over to the next day from the perspective of Central Time
      # (it is 1 am Central Time the next day). These asserts also verify that time zone conversion
      # that spill across days is also accurately reflected.
      availabilities = @PDT_mentor.reload.availabilities_by_day

      expect(availabilities[:sunday]).to eq([14])
      expect(availabilities[:monday]).to eq([14])
      expect(availabilities[:tuesday]).to eq([14, 17])
      expect(availabilities[:wednesday]).to be_nil
      expect(availabilities[:thursday]).to eq([1])
      expect(availabilities[:friday]).to be_nil
      expect(availabilities[:saturday]).to be_nil
    end
  end
end
