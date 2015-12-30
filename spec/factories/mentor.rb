require 'securerandom'

module Factories
  class Mentor
    def self.create!(options = {})
      build(options).tap { |mentor| mentor.save! }
    end

    def self.build(options = {})
      ::Mentor.new(
				confirmed_at: options.fetch(:confirmed_at, Date.today),
        admin: options.fetch(:admin, false),
        name: options.fetch(:name, "Test"),
        email: options.fetch(:email, "#{SecureRandom.hex(10)}@test.com"),
        password: options.fetch(:password, "#{SecureRandom.hex(10)}")
      )
    end
  end
end
