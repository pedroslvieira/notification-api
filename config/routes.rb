Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :notifications, only: [ :index, :show, :update, :create, :destroy ] do
        resources :user_notifications, only: [ :show, :create, :destroy ]
      end
    end
  end
  root to: 'pages#home'
end
