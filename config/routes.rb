Rails.application.routes.draw do
  devise_for :users
  
  root "users#index"
  get "/users/:user_id/posts", to: "posts#index", as: "user_posts"
  get "/users/:user_id/posts/:id", to: "posts#show", as: "user_post"
  get "/users", to: "users#index", as: "users"
  get "/users/:id", to: "users#show", as: "user"

  get '/posts/new', to: 'posts#new', as: 'new_post'
  post '/posts', to: 'posts#create', as: 'post'

  get '/users/:user_id/posts/:id/new_comment', to: 'comments#new', as: 'new_comment'
  post '/users/:user_id/posts/:id/comment', to: 'comments#create', as: 'comment'

  post '/users/:user_id/posts/:id/like', to: 'likes#create', as: 'like'
  post '/users/:user_id/posts/:id/destroy', to: 'posts#destroy', as: 'delete_post'
  post '/users/:user_id/:id/destroy', to: 'comments#destroy', as: 'delete_comment'
end
