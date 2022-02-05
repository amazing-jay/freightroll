Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "sessions#index"

  devise_for :users

  resources :sessions, except: :destroy
  resources :shipments, only: [:new, :show]
end
