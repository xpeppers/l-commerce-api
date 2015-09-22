Rails.application.routes.draw do
  namespace :api do
    post 'auth/', to: 'auth#create'
    resources :offers, except: [:new, :edit]
    resources :users, except: [:new, :edit]
    resources :orders, except: [:new, :edit] do
      resources :payments, except: [:new, :edit]
    end
    get '/', to: 'status#index'
  end
end
