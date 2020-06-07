Rails.application.routes.draw do
  resources :enrollments do
    get :my_students, on: :collection
    member do
      get :certificate
    end
  end
  devise_for :users, controllers: {  registrations: "users/registrations", omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :lessons
  resources :courses do
    get :purchased, :pending_review, :created, :unapproved, on: :collection
    member do 
      patch :approve
      patch :unapprove
    end
    resources :lessons, except: [:index] do
      resources :comments, except: [:index]
      put :sort
      member do
        delete :delete_video
      end
    end
    resources :enrollments, only: [:new, :create]
  end

  resources :users, only: [:index, :edit, :update, :show]
  root 'home#index'
  get 'activity', to: 'home#activity'
  get 'privacy_policy', to: 'home#privacy_policy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

