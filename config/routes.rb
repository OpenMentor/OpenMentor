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
  resources :skill_proposals
  get 'skill_proposals' => 'skill_proposals#index', as: :skill_proposals
  get 'skill_proposals/new' => 'skill_proposals#new', as: :skill_proposal_new
  put 'skill_proposals/create' => 'skill_proposals#create', as: :skill_proposal_create

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
