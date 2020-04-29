Rails.application.routes.draw do
  devise_for :users
  root to: 'meals#feature'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :meal do
    collection do
      get 'offered', to: 'meals#offered', as: :meals_offered
    end
    member do
      get 'eaters', to: 'bookings#eaters', as: :meal_eaters
    end
    resources :booking, only: :create
    resources :review, only: [:index, :create]
  end
  resources :booking, except: [:create, :new]
end
