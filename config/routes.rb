Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'top#index'
  namespace :api, format: 'json' do
    namespace :auth do
      resource :login, only: :create
    end
    authenticated :admin_user do
      # 特権管理者のみ許可するAPI
      authenticated :admin_user, lambda { |user| user.is_user_administrator } do
        resources :admin_users, except: [:new, :edit]
      end

      resource :profile, only: :show
    end
  end
end
