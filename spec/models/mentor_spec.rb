require 'spec_helper'

describe Mentor do
  context "#availabilites_by_day" do
    before do
      @mentor = Factories::Mentor.create!
      availability1 = Availability.create(mentor: @mentor, day: "sunday", start_hour: 1, end_hour: 3)
      availability2 = Availability.create(mentor: @mentor, day: "monday", start_hour: 1, end_hour: 3)
      availability3 = Availability.create(mentor: @mentor, day: "tuesday", start_hour: 1, end_hour: 3)
      availability4 = Availability.create(mentor: @mentor, day: "tuesday", start_hour: 6, end_hour: 10)
    end

    it "returns a hash structured like { day: [start_hour..end_hour] }" do
      availabilities = @mentor.reload.availabilities_by_day

      expect(availabilities["sunday"]).to eq([1, 2, 3])
      expect(availabilities["monday"]).to eq([1, 2, 3])
      expect(availabilities["tuesday"]).to eq([1, 2, 3, 6, 7, 8, 9, 10])
      expect(availabilities["wednesday"]).to be_nil
      expect(availabilities["thursday"]).to be_nil
      expect(availabilities["friday"]).to be_nil
      expect(availabilities["saturday"]).to be_nil
    end
  end
end
