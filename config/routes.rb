Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/, defaults: { locale: I18n.default_locale } do
    devise_for :users

    root 'home#index', as: 'home'
    get 'about' => 'home#about'
    get "/404", to: "errors#not_found"
    get "/422", to: "errors#unacceptable"
    get "/500", to: "errors#server_error"

    resources :osbbs, only: %i[index show]
    namespace :account do
      resources :users, except: %i[index destroy]
      resources :utility_providers, only: %i[index new update] do
        get 'search', on: :collection
        put 'disassociate', on: :member
      end
      namespace :admin do
        resources :osbbs, except: %i[index show]
        resources :user_cabinets, only: :index
        resources :companies do
          resources :billing_contracts
        end
        resources :users, only: %i[index destroy]
      end
    end
  end
end
