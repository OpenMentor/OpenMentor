
namespace :skills do
  desc "seed initial skills"
  task :seed => :environment do
    $: << File.expand_path("../../../db", __FILE__)
    file = File.open("db/skills_list_seeds.txt", "r")

    puts "Creating the following skills:"
    file.each_line do |skill_name|
      begin
        puts "- #{skill_name}"
        Skill.create!(name: skill_name.capitalize)
      rescue ActiveRecord::RecordInvalid
      end
    end
  end
end

