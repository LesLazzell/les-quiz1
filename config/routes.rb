Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  resources :issues, permit: [:new, :create, :show]
end
