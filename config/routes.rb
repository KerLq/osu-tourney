Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'homes#index'

  get '/register', to: 'sessions#register'
  post '/register', to: 'users#create'


end
