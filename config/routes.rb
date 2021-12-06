Rails.application.routes.draw do 
  resources :comments, :homes, :admin ,only:[:index,:show]
  resources :tags, only:[:show]

  resources :posts, path: '/homes/:user_id/posts', only:[:new,:create,:edit,:destroy,:update]
  resources :posts, path: '/admin/:user_id/posts',  only:[:new,:create,:edit,:destroy,:update]
  devise_for :users

  get '/posts/:id' => 'posts#show'
  root to: "homes#index"
  post 'rates' => 'rates#create'
  post 'likes' => 'likes#create'
  get '/find/:value' => 'homes#find'

end
