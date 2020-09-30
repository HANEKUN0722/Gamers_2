Rails.application.routes.draw do
  root "homes#top"
  get "home/about"
  devise_for :users
  resources :users
  resources :games
  get 'reviews/index'
  get 'reviews/show'
  get 'reviews/new'
  get 'reviews/edit'
  get 'mails/index'
  get 'mails/show'
  get 'mails/new'
  get 'mails/edit'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
