Rails.application.routes.draw do
  require 'sidekiq/web'
  filter :locale
  devise_for :users, controllers: { registrations: 'user/registrations' }

  mount Sidekiq::Web => '/sidekiq'
  root 'home#index', as: 'home'
  get 'about', to: 'home#about'
  get "/404", to: "errors#not_found"
  get "/422", to: "errors#unacceptable"
  get "/500", to: "errors#server_error"

  namespace :account do
    resources :payments, only: %i[index show]
    resources :users, only: %i[show edit update]
    resources :companies do
      resources :utility_providers, only: %i[new update]
    end
    resources :utility_providers, only: %i[index show] do
      get 'search', on: :collection
      put 'disassociate', on: :member
      resources :meter_readings, only: %i[index new create]
    end
    namespace :admin do
      resources :osbbs
      resources :companies do
        resources :billing_contracts do
          collection do
            get 'new_import'
            post 'import'
          end
        end
        get 'new_import', on: :collection
        post 'import', on: :collection
      end
      resources :payments, only: %i[new_import import] do
        collection do
          get 'new_import'
          post 'import'
        end
      end
      resources :users, only: %i[index destroy]
      resources :bills, only: %i[new_import import] do
        collection do
          get 'new_import'
          post 'import'
        end
      end
      get 'start_impersonate', to: 'admin#start_impersonate', as: 'start_impersonate'
      get 'stop_impersonating', to: 'admin#stop_impersonating', as: 'stop_impersonate'
    end
  end
  telegram_webhook TelegramWebhooksController
end
