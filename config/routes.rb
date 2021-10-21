Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'homes#index'

  # get '/register', to: 'users#register'
  # post '/register', to: 'users#create'
  # get '/login', to: 'sessions#login'
  # post '/login', to: 'sessions#create'
  # get '/logout', to: 'sessions#destroy'
  # post '/logout', to: 'sessions#destroy'
  get '/parse', to: 'parses#index'
  post '/parse', to: 'parses#parse'

  # resources :users

  get '/oauth2-callback', to: 'oauth#oauth_callback'
  get '/logout', to: 'oauth#logout'
  get '/login', to: 'oauth#login'
end
