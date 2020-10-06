Rails.application.routes.draw do
  root "homes#top"
  get "home/about"
  devise_for :users
  resources :users
  resources :games do
    resources :reviews, only: [:create, :destroy]
  end
  get 'mails/index'
  get 'mails/show'
  get 'mails/new'
  get 'mails/edit'
  resources :relationships, only: [:create, :destroy]
  resources :users do
    member do
     get :following, :followers
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
