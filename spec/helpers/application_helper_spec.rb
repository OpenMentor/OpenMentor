require 'spec_helper'

describe ApplicationHelper do

  subject { class Test; include ApplicationHelper; end.new }

  it "returns the week days of the week" do
    expect(subject.weekdays).to eq(Availability::WDAYS.keys)
  end
end
