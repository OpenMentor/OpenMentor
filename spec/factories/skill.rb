require 'securerandom'

module Factories
  class Skill
    def self.create!(options = {})
      build(options).tap { |skill| skill.save! }
    end

    def self.build(options = {})
      ::Skill.new(name: options.fetch(:name, SecureRandom.hex(10)))
    end
  end
end
