Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  get 'home/about' => 'home#show', as: 'about'
  resources :home, only: [:new, :create, :show]
  resources :users
  resources :books
  post 'books/:id/comment' => 'post_comments#create', as: 'book_post_comments'
end
