Rails.application.routes.draw do
  resources :users, except: [:new, :edit]
  namespace :api do
    resources :offers, except: [:new, :edit]
  end
end
