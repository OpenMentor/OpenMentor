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

  has_many :skill_proposals, foreign_key: 'proposed_by'
  has_many :reviewed_skill_proposals, class_name: 'SkillProposal', foreign_key: 'reviewed_by'
  has_many :mentor_skills, dependent: :destroy
  has_many :skills, through: :mentor_skills
  has_many :availabilities

  # Paperclip settings
  has_attached_file :profile_picture, styles: { medium: "300x300>", thumb: "95x95>" }, default_url: "/assets/avatars/3.png"
  validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\Z/
end
