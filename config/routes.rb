# frozen_string_literal: true

Rails.application.routes.draw do
  resources :switches do
    resources :checkins
    resources :releases
  end
  devise_for :users

  root to: 'home#index'
end
