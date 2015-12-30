class AddAttachmentProfilePictureToMentors < ActiveRecord::Migration
  def self.up
    change_table :mentors do |t|
      t.attachment :profile_picture
    end
  end

  def self.down
    remove_attachment :mentors, :profile_picture
  end
end
