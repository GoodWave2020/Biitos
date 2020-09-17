Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  get '/users/profile/:id', to: 'users#show', as: 'user'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  resources :posts
  root 'posts#index'
end
