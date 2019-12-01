Rails.application.routes.draw do
  resources :tracks
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
