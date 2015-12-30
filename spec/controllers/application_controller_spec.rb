require 'spec_helper'

describe ApplicationController do

  context "custom_error" do
    it "returns an ActiveModel::Errors instance for the given params" do
      test_object = Object.new
      error_attribute = :test
      error_message = "Test error message"
      result = subject.custom_error(test_object, {error_attribute => error_message})

      expect(result.messages[error_attribute]).to eq(error_message)
    end
  end

  context "render_404" do
    it "raises ActionController::RoutingError" do
      expect { subject.render_404 }.to raise_error(error_404)
    end
  end

  context "validate_admin!" do
    it "does not raise error if current_mentor is an admin" do
      as_admin do
        expect { subject.validate_admin! }.to_not raise_error
      end
    end

    it "raises ActionController::RoutingError if current_mentor is not admin" do
      as_mentor do
        expect { subject.validate_admin! }.to raise_error(error_404)
      end
    end
  end
end
