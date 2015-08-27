Rails.application.routes.draw do
  namespace :api do
    resources :offers, except: [:new, :edit]
    resources :users, except: [:new, :edit]
  end
end
