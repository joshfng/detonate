Rails.application.routes.draw do
  resources :switches
  devise_for :users
  
  root to: 'home#index'
end
