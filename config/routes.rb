Rails.application.routes.draw do
  namespace :api do
    get '/', to: 'status#index'
    post 'auth/merchants', to: 'auth_merchants#create'
    post 'auth/', to: 'auth_users#create'
    get 'bought_offers/', to: 'bought_offers#index'
    get 'bought_offers/:id', to: 'bought_offers#show'
    get 'sold_offers/', to: 'sold_offers#index'
    put 'sold_offers/:id', to: 'sold_offers#update'
    get 'profile/', to: 'profile#show'

    resources :offers, except: [:new, :edit]
    resources :users, except: [:new, :edit]
    resources :orders, except: [:new, :edit] do
      resources :payments, except: [:new, :edit]
    end

    resource :reseller, only: [:show]
    resources :paths, except: [:new, :edit] do
      resources :stages, except: [:new, :edit]
    end
  end

  namespace :backoffice do
    get '/', to: 'offers#index'
    resources :offers
    resources :merchants
    resources :paths do
      resources :stages
    end

    resource :reseller, only: [:show, :edit, :update]
    resources :images, only: [:create, :destroy]
  end
end
