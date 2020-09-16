Rails.application.routes.draw do
  devise_for :users
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  resources :posts
  root 'posts#index'
end
