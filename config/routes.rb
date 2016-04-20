Rails.application.routes.draw do

  get '/'       => 'application#index'
  get '/home'   => 'application#index'
  get '/login'   => 'application#login'
  get '/logout'  => 'application#logout'

  post '/login'  => 'application#try_login'
  post '/add_group'  => 'products#add_group'
  post '/remove_group'  => 'products#remove_group'
  post '/get_groups' => 'products#get_groups'
  post '/get_all_other_groups' => 'products#get_all_other_groups'


  resources :products
  resources :workers
  resources :groups

end
