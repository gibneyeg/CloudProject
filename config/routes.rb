Rails.application.routes.draw do
  root 'books#index'
  
  devise_for :users
  
  resources :books do
    member do
      post 'borrow'
      post 'return'
    end
  end
  resources :categories
  resources :borrowings
end