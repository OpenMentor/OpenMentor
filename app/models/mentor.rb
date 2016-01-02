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

  # Paperclip settings
  has_attached_file :profile_picture, styles: { medium: "300x300>", thumb: "95x95>" }, default_url: "/assets/avatars/3.png"
  validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\Z/

  def time_zone_valid
    errors.add(:time_zone, "#{time_zone} is not a valid time zone") unless ActiveSupport::TimeZone.new(time_zone)
  end

  def availabilities_by_day
    availabilities.each_with_object({}) do |availability, availabilities|
      availabilities[availability.day] ||= []
      [*availability.start_hour..availability.end_hour].each do |hour|
        availabilities[availability.day] << hour
      end
    end
  end
end
