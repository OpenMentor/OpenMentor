
namespace :initialize do

  desc "seed all (for development / test purposes only)"
  task :all => :environment do
    seed_skills
    seed_mentors
  end

  desc "seed initial skills"
  task :skills => :environment do
    seed_skills
  end

  desc "seed initial mentors"
  task :mentors => :environment do
    seed_mentors
  end

  def initialize_load_path
    $: << File.expand_path("../../../db", __FILE__)
  end

  def seed_skills
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

  def seed_mentors
    file = File.open("db/mentors_list_seeds.txt", "r")

    puts "Creating the following mentors:"
    file.each_line do |mentor_name|
      begin
        puts "- #{mentor_name}"
        email = "#{mentor_name.downcase.gsub(/\ /, "_").gsub(/\n/, "")}@test.com"
        Mentor.create!(
          confirmed_at: Date.today,
          admin: false,
          name: mentor_name,
          email: email,
          password: "password"
        )
      rescue ActiveRecord::RecordInvalid
      end
    end
  end

  initialize_load_path
end
