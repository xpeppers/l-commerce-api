Rails.application.routes.draw do
  namespace :api do
    resources :offers, except: [:new, :edit]
    resources :users, except: [:new, :edit]
    get '/', to: 'status#index'
  end
end
