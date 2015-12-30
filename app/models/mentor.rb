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

  has_many :skill_proposals, foreign_key: 'proposed_by'
  has_many :reviewed_skill_proposals, class_name: 'SkillProposal', foreign_key: 'reviewed_by'

  # Paperclip settings
  has_attached_file :profile_picture, styles: { medium: "300x300>", thumb: "95x95>" }, default_url: "/assets/:style/missing.png"
  validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\Z/
end
