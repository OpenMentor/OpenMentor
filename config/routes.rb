Rails.application.routes.draw do
  devise_for :mentors

  root 'mentors#index'

  # Mentors
  get 'mentors' => 'mentors#index', as: :mentors
  get 'mentors/:id'  => 'mentors#show', as: :mentor_show

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

  # Availabilities (scoped to mentor)
  get 'mentors/:id/availabilities' => 'mentors/availabilities#index', as: :availabilities

  # Availabilities (for the current mentor)
  get 'mentor/availabilities/edit' => 'mentors/availabilities#edit', as: :availabilities_edit
  patch 'mentor/availabilities/update' => 'mentors/availabilities#update', as: :availabilities_update

  # Conversations
  get 'conversations' => 'conversations#index', as: :conversations
  get 'conversations/new' => 'conversations#new', as: :conversations_new
  get 'conversations/:id' => 'conversations#show', as: :conversations_show
  put 'conversations/create' => 'conversations#create', as: :conversations_create
end
