Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    devise_for :admin_users,
               path: 'auth',
               :skip => [:registrations, :passwords, :confirmations, :unlocks]
    authenticated :admin_user do

    end
  end
end
