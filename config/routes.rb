Highscore::Application.routes.draw do
  resources :games do
    resources :scores
  end
end
