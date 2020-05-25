Rails.application.routes.draw do
  resources :enrollments
  devise_for :users
  resources :lessons
  resources :courses do
    resources :lessons
    resources :enrollments, only: [:new, :create]
  end

  resources :users, only: [:index, :edit, :update, :show]
  root 'home#index'
  get 'home/activity'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
