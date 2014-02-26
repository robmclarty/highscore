Highscore::Application.routes.draw do

  # Authorization
  resources :sessions, :only => [:create]
  resources :users
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  get 'signup' => 'users#new', :as => :signup

  resources :games do
    resources :scores
  end

  root 'sessions#new'
end
