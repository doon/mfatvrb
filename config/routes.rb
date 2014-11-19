Rails.application.routes.draw do

  get 'dashboard/index'

  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  resources :sessions
  resources :users
  resources :two_factor

  root :to => 'dashboard#index'

end
