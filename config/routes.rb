# frozen_string_literal: true

Rails.application.routes.draw do
  get '/heartbeats/:id', to: 'heartbeat#heartbeat'

  resources :switches do
    resources :heartbeat_destinations
    resources :releases
  end
  devise_for :users

  root to: 'home#index'
end
