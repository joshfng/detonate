# frozen_string_literal: true

Rails.application.routes.draw do
  get '/heartbeats/:id', to: 'heartbeats#receive_heartbeat', as: :heartbeat_receive

  resources :switches do
    resources :heartbeat_destinations
    resources :switch_destination
  end
  devise_for :users

  # TODO: lock down to admin
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: 'home#index'
end
