class AddTimezoneToMentors < ActiveRecord::Migration
  def change
    add_column :mentors, :time_zone, :string, default: "UTC"
  end
end
