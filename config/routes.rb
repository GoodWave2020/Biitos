Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get '/users/profile/:id', to: 'users#show', as: 'user'
  get '/users/following/:id', to: 'users#following', as: 'following'
  get '/users/followers/:id', to: 'users#followers', as: 'followers'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :posts do
    resources :comments
  end
  root 'posts#index'
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
