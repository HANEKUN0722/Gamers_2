Rails.application.routes.draw do
  root "homes#top"
  get "home/about"
  devise_for :users
  resources :users do
    member do
      #フォロー機能
      get :following, :followers
      #お気に入り機能
      get :favorites
    end
  end
  #DM機能
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  resources :games do
    #コメント機能
    resources :reviews, only: [:create, :destroy]
    #お気に入り機能
    resource :favorites, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
