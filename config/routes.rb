# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  get '/heartbeats/:id', to: 'heartbeats#receive_heartbeat', as: :heartbeat_receive

  resources :switches do
    resources :heartbeat_destinations
    resources :switch_destinations
  end
  devise_for :users

  authenticate :user, ->(u) { u.admin? } do
    namespace :admin do
      Sidekiq::Web.disable :sessions
      mount Sidekiq::Web, at: 'sidekiq'
      mount PgHero::Engine, at: 'pghero'
    end
  end

  root to: 'home#index'
end
