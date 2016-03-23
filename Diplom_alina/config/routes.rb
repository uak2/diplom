Rails.application.routes.draw do

  resources :photos
  resources :groups
  resources :people
  resources :specialities
  resources :plans
  resources :terms
  resources :subdivisionsrvm
  resources :passports
  resources :addresses
  resources :role_users
  resources :users
  resources :roles
  resources :students, :except => [:destroy]


  #delete this. It's use for debug
  get 'del_all' => "students#del_all"


  #========= SEARCH STUDENTS ========
  get 'search' => 'searches#new', as: :search
  root :to => 'searches#new'
  get 'result' => 'searches#result'
  #============ SESSIONS ============
  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy', as: :logout
end
