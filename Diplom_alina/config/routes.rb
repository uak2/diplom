Rails.application.routes.draw do

  resources :photos
  resources :groups
  resources :people
  resources :specialities
  resources :plans
  resources :terms
  resources :subdivisions
  resources :passports
  resources :addresses
  resources :role_users
  resources :users
  resources :roles
  resources :students, :only => [:update, :show, :edit, :new, :create]

  #========= SEARCH STUDENTS ========
  get 'search' => 'searches#new', as: :search
  root :to => 'searches#new'
  get 'result' => 'searches#result'

  #============ SESSIONS ============
  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy', as: :logout


  #============ AJAX ================
  post 'state_by_date' => 'students#state_by_date'
  post 'create_year' => 'terms#create_year'
  post 'create_type_subdivision' => 'subdivisions#create_type'
  post 'create_subdivision' => 'subdivisions#create'
  post 'subdivisions_for_select' => 'subdivisions#subdivisions_for_select'
  post 'change_active_role' => 'users#change_active_role'
  post 'create_role' => 'roles#create'
end
