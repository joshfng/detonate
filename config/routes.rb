# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  get '/heartbeats/:id', to: 'heartbeats#receive_heartbeat', as: :heartbeat_receive

  resources :switches
  devise_for :users

  authenticate :user, ->(u) { u.admin? } do
    namespace :admin do
      mount Sidekiq::Web, at: 'sidekiq'
      mount PgHero::Engine, at: 'pghero'
      mount Avo::Engine, at: 'avo'
    end
  end

  root to: 'home#index'
end
