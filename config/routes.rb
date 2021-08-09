Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'homes#index'

  get '/register', to: 'sessions#index'
  post '/register', to: 'sessions#create'

end
