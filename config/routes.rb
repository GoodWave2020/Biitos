Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get '/users/profile/:id', to: 'users#show', as: 'user'
  get '/users/following/:id', to: 'users#following', as: 'following'
  get '/users/followers/:id', to: 'users#followers', as: 'followers'
  get '/users/friends/:id', to: 'users#friend_index', as: 'friends'
  get '/users/favorites/:id', to: 'users#favorites_index', as: 'user_favorites'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :posts do
    resources :comments
  end

  resources :conversations do
    resources :dm_messages do
      member do
        get :download
      end
    end
  end

  root 'posts#index'
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]

  resources :notifications, only: :index
  delete '/notifications', to: 'notifications#destroy_all', as: 'destroy_all_notifications'
end
