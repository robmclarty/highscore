require 'api_contraints'

Highscore::Application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    scope module: :v1, contraints: ApiContraints.new(version: 1, default: true) do
      resources :scores
    end
    # scope module: :v2, contraints: ApiContraints.new(version: 2, default: true) do
    #   resources :scores
    # end
  end

  # Authorization
  resources :sessions, :only => [:create]
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  get 'signup' => 'users#new', :as => :signup

  resources :users
  get '/users/:id/generate_api_key' => 'users#generate_api_key', :as => :user_generate_api_key

  resources :games do
    resources :scores
  end

  root 'sessions#new'
end
