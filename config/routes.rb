Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'todos#index'
  resources :todos
  resources :categories
  resources :users, only: [:new, :create]
  resources :viewers
end
