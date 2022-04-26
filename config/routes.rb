require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  mount Sidekiq::Web => '/jobs'

  resource :spendings
end
