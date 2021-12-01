Rails.application.routes.draw do
  resources :posts, :comments, :rates, :homes

  devise_for :users

  root to: "homes#index"

  post 'likes' => 'likes#create'
  get '/find/:value' => 'homes#find'

end
