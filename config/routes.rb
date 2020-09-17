Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get '/users/profile/:id', to: 'users#show', as: 'user'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  resources :posts do
    resources :comments
  end
  root 'posts#index'
  resources :relationships, only: [:create, :destroy]
end
