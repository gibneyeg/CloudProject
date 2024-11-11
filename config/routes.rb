Rails.application.routes.draw do
  # Devise routes must come first
  devise_for :users
  
  root 'books#index'

  resources :books do
    member do
      post :borrow
      post :return
    end
  end
  
  resources :categories
  resources :borrowings
end