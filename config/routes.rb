Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#new'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/auth/facebook/callback' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  resources :recipes, only: %i[index show]

  resources :ingredients, only: %i[index new create destroy]

  resources :users, only: %i[new create show edit update] do
    resources :recipes
    resources :dishes
  end

  resources :recipes, only: %i[show] do
    resources :substitutions, only: %i[new index create destroy]
  end

  post '/like' => 'likes#like'
  delete '/unlike' => 'likes#unlike'
end
