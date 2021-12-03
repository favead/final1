Rails.application.routes.draw do
  resources :posts, :comments, :homes, :admin

  devise_for :users

  root to: "homes#index"
  post 'rates' => 'rates#create'
  post 'likes' => 'likes#create'
  get '/find/:value' => 'homes#find'

end
