Rails.application.routes.draw do
  post 'login', to: 'sessions#create'
  get 'verify', to: 'sessions#verify'
  post 'register', to: 'users#create'
end
