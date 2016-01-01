Rails.application.routes.draw do
  devise_for :mentors

  root 'mentors#index'

  # Mentors
  get 'mentors' => 'mentors#index', as: :mentors
  get 'mentor/:id'  => 'mentors#show', as: :mentor_show

  # Mentor Profile
  get 'profiles/edit' => 'mentors#edit', as: :mentor_edit
  patch 'profiles/update' => 'mentors#update', as: :mentor_update

  # MentorSkills
  get 'mentor_skills/edit' => 'mentor_skills#edit', as: :mentor_skills_edit
  patch 'mentor_skills/update' => 'mentor_skills#update', as: :mentor_skills_update

  # Skills
  get 'skills' => 'skills#index', as: :skills
  get 'skills/new' => 'skills#new', as: :skill_new
  put 'skills/create' => 'skills#create', as: :skill_create

  # SkillProposals
  get 'skill_proposals' => 'skill_proposals#index', as: :skill_proposals
  get 'skill_proposals/new' => 'skill_proposals#new', as: :skill_proposal_new
  put 'skill_proposals/create' => 'skill_proposals#create', as: :skill_proposal_create

  # Availabilities (scoped to Mentor)
  get 'mentor/:id/availabilities' => 'mentors/availabilities#index', as: :availabilities
end
