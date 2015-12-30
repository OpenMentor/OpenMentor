class AddAdminToMentors < ActiveRecord::Migration
  def change
    add_column :mentors, :admin, :boolean, default: false
  end
end
