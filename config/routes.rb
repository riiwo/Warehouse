Rails.application.routes.draw do

  get '/'       => 'application#index'
  get '/home'   => 'application#index'
  get '/login'   => 'application#login'
  get '/logout'  => 'application#logout'

  post '/login'  => 'application#try_login'
  post '/add_group'  => 'products#add_group'
  post '/remove_group'  => 'products#remove_group'


  resources :roles
  resources :products
  resources :workers
  resources :groups

end
