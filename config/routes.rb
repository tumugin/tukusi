Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: proc { [404, {}, ["Not found."]] }

  devise_for :admin_users,
             path: 'api/auth',
             skip: [:registrations, :confirmations, :unlocks],
             controllers: {
               passwords: 'api/passwords',
               sessions: 'api/sessions'
             },
             defaults: { :format => 'json' }

  namespace :api, format: 'json' do
    authenticated :admin_user do
      # 特権管理者のみ許可するAPI
      authenticated :admin_user, lambda { |user| user.is_user_administrator } do
        resources :admin_users, except: [:new, :edit]
      end
    end
  end
end
