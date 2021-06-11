Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # deviseのコントローラは使用しないが有効化はしておく
  devise_for :admin_users, skip: :all

  root to: 'top#index'

  namespace :api, format: 'json' do
    namespace :auth do
      resource :login, only: :create
      resource :logout, only: :create
    end
    resource :meta, only: :show

    resources :admin_users, except: [:new, :edit]
    resource :profile, only: [:show, :update]
    resources :notify_targets, except: [:new, :edit]
    resources :subscriptions, except: [:new, :edit] do
      resources :crawl_logs, only: [:index, :show]
    end
  end
end
