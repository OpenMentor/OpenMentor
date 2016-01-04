class Mentor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable,
         :lockable

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :time_zone, presence: true

  validate :time_zone_valid

  has_many :skill_proposals, foreign_key: 'proposed_by'
  has_many :reviewed_skill_proposals, class_name: 'SkillProposal', foreign_key: 'reviewed_by'
  has_many :mentor_skills, dependent: :destroy
  has_many :skills, through: :mentor_skills
  has_many :availabilities

  has_and_belongs_to_many :conversations
  has_many :messages, foreign_key: "sender_id"

  # Paperclip settings
  has_attached_file :profile_picture, styles: { medium: "300x300>", thumb: "95x95>" }, default_url: "/assets/avatars/3.png"
  validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\Z/

  def time_zone_valid
    errors.add(:time_zone, "#{time_zone} is not a valid time zone") unless ActiveSupport::TimeZone.new(time_zone)
  end

  def availabilities_by_day
    # Danger! This method is short, but has large density.
    #
    # Time Zones are tricky. This method is designed to make
    # maximum use of Ruby and ActiveSupport's built in time zone
    # related helper methods.
    #
    # Before altering the behavior of this method, please ask
    # yourself the following questions:
    #
    # 1. Do I fully understand the implications of making the proposed change?
    # 2. Are all existing tests passing after making the change?
    # 3. Do I have to alter existing tests to satisfy the change?
    #
    # If you answer no to any of the three questions above, it is probably
    # a change that needs to be re-thought. Please open an issue or PR,
    # start a conversation, and get more minds thinking about the proposal
    # because "Time Zones Are Hard"    ^_____^v

    inverted_days = Availability::WDAYS.invert
    availabilities.each_with_object({}) do |availability, availabilities|
      availabilities[inverted_days[availability.start.wday]] ||= []
      availabilities[inverted_days[availability.start.wday]] << availability.start.hour
    end
  end
end
