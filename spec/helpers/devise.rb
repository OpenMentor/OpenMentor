def as_admin(admin = Factories::Mentor.create!(admin: true))
  @request.env["devise.mapping"] = Devise.mappings[:admin]
  sign_in admin
	yield
end

def as_mentor(mentor = Factories::Mentor.create!)
  @request.env["devise.mapping"] = Devise.mappings[:user]
  sign_in mentor
  yield
end
