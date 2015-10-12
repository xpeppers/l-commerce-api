Rails.application.routes.draw do
  namespace :api do
    get '/', to: 'status#index'
    post 'auth/', to: 'auth#create'
    get 'bought_offers/', to: 'bought_offers#index'
    get 'bought_offers/:id', to: 'bought_offers#show'
    get 'profile/', to: 'profile#show'

    resources :offers, except: [:new, :edit]
    resources :users, except: [:new, :edit]
    resources :orders, except: [:new, :edit] do
      resources :payments, except: [:new, :edit]
    end
  end

  namespace :backoffice do
    get '/', to: 'offers#index'
    resources :offers
    resources :merchants
  end
end
