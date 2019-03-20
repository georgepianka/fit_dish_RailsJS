Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/auth/facebook/callback' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  resources :recipes, only: %i[index show]

  resources :ingredients, only: %i[index show new create destroy]

  resources :users, only: %i[new create show edit update] do
    resources :recipes
    resources :dishes
  end

  resources :recipes, only: %i[show] do
    resources :ingredients, only: %i[index new create]
    resources :substitutions, only: %i[new create]
  end

  post '/like' => 'likes#like'
  delete '/unlike' => 'likes#unlike'
end
