Rails.application.routes.draw do
  devise_for :users
  resources :users
  root 'home#index'
  get 'home/about' => 'home#show', as: 'about'
  resources :home, only: [:new, :create, :show]
  resources :books
  post 'books/:id/comment' => 'comments#create', as: 'book_comments'
end
