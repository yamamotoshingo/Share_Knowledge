Rails.application.routes.draw do

  namespace :admin do
    resources :users, only: [:index]
    resource :user, only: [:destroy] do
      patch :withdrawal, :lift, on: :collection
    end
    resources :knowledges, only: [:index, :show, :destroy]
    resources :categories, only: [:index]
    resource :categories, only: [:destroy]
    resources :comments, only: [:index, :destroy] do
      delete :destroy_all, on: :collection
    end
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

  devise_for :users, skip: [:password], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :user do
    post 'users/user_guest_sign_in', to: 'public/sessions#user_guest_sign_in'
    post 'users/admin_guest_sign_in', to: 'public/sessions#admin_guest_sign_in'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
