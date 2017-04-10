Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help', to: 'static_pages#help'
  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/squadselection', to: 'teams#select'
  get '/selected', to: 'teams#selected'
  resources :users
  resources :categories
  resources :teams
  resources :account_activations, only: [:edit]
end
