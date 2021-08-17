require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # deviseのコントローラは使用しないが有効化はしておく
  devise_for :admin_users, skip: :all

  # Sidekiq
  authenticated :admin_user, ->(user) { user.is_user_administrator } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: 'top#index'

  namespace :api, format: 'json' do
    namespace :auth do
      resource :login, only: :create
      resource :logout, only: :create
    end
    resource :meta, only: :show

    resources :admin_users, except: %i[new edit]
    resource :profile, only: %i[show update]
    resources :notify_targets, except: %i[new edit]
    resources :subscriptions, module: :subscriptions, except: %i[new edit] do
      resources :crawl_logs, only: %i[index show]
      resource :perform_crawl, only: [:create]
    end
  end
end
