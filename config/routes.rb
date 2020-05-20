Rails.application.routes.draw do
  resources :users, only: [:index, :edit, :show, :update]
  resources :courses
  devise_for :users
  root 'home#index'
  get 'home/activity'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
