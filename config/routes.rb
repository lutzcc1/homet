Rails.application.routes.draw do
  devise_for :users
  root to: 'meals#featured'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :meals do
    collection do
      get 'offered', to: 'meals#offered', as: :meals_offered
    end
    member do
      get 'eaters', to: 'bookings#eaters', as: :meal_eaters
    end
    resources :bookings, only: :create
    resources :reviews, only: [:index, :create]
  end
  resources :bookings, except: [:create, :new]
end
