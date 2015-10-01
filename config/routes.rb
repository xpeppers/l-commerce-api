Rails.application.routes.draw do
  namespace :api do
    post 'auth/', to: 'auth#create'
    resources :offers, except: [:new, :edit]
    resources :users, except: [:new, :edit]
    resources :orders, except: [:new, :edit] do
      resources :payments, except: [:new, :edit]
    end
    get 'bought_offers/', to: 'bought_offers#index'
    get 'bought_offers/:id', to: 'bought_offers#show'
    get 'profile', to: 'profile#show'
    get '/', to: 'status#index'
  end

  namespace :backoffice do
    get '/', to: 'offers#index'
    resources :offers
  end
end
