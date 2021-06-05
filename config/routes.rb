Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, format: 'json' do
    devise_for :admin_users,
               path: 'auth',
               :skip => [:registrations, :confirmations, :unlocks]
    authenticated :admin_user do
      # 特権管理者のみ許可するAPI
      authenticated :admin_user, lambda { |user| user.is_user_administrator } do
        resources :admin_users, except: [:new, :edit]
      end
    end
  end
end
