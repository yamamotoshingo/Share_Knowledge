Rails.application.routes.draw do

  namespace :admin do
    resources :users, only: [:index, :destroy]
    resources :knowledges, only: [:index, :show, :destroy]
    resources :categories, only: [:index, :destroy]
    resources :comments, only: [:index, :destroy]
  end

  scope module: :public do

  resources :categories, only: [:create, :update]
  resources :knowledges do
    resources :comments, only: [:new, :create, :destroy]
    get :choose, on: :collection
  end
  resource :users, only: [:show, :update] do
    patch :withdrawal, on: :collection
  end

  end

  root to: 'public/homes#top'

  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions",
    passwords: "public/passwords"
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/users/sessions#guest_sign_in'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
