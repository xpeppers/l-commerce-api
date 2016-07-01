Rails.application.routes.draw do
  namespace :api do
    get '/', to: 'status#index'
    post 'auth/merchants', to: 'auth_merchants#create'
    post 'auth/', to: 'auth_users#create'
    post 'users/reset_password_auto', to: 'users#reset_password_auto'
    post 'users/reset_password', to: 'users#reset_password'
    post 'users/temporary_login', to: 'users#temporary_login'
    get 'device_token', to: 'device_token#index'
    post 'device_token', to: 'device_token#create'
    get 'bought_offers/', to: 'bought_offers#index'
    get 'bought_offers/:id', to: 'bought_offers#show'
    get 'sold_offers/', to: 'sold_offers#index'
    put 'sold_offers/:id', to: 'sold_offers#update'
    get 'profile/', to: 'profile#show'
    post 'generic_notify/', to: 'offers#generic_notify'
    post 'notification/ios', to: 'notification#ios'
    post 'notification/android', to: 'notification#android'

    resources :offers, except: [:new, :edit] do
      post 'notify'
    end
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

    resources :orders, only: [:index]
    resource :reseller, only: [:show, :edit, :update]
    resources :images, only: [:create, :destroy]
    resources :users, only: [:index]
  end


  namespace :frontend do
      resources :offers,  only: [:show, :index]
  end
end
