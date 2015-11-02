Rails.application.routes.draw do


  #devise_for :users
  devise_for :users, :controllers => {:registrations => 'registrations', :sessions => 'devise/sessions'}
  delete "/users/sign_out", :to => 'devise/sessions#destroy'


  resources :lists do
    resources :items
  end

  put '/lists/:list_id/items/mark_complete/:id' => 'items#mark_complete'
  put '/lists/:list_id/items/mark_incomplete/:id' => 'items#mark_incomplete'
  post '/lists/:list_id/items/sort' => 'items#sort'
  get '/lists/:list_id/items/mark_complete/:id' => 'items#mark_complete'
  get '/lists/:list_id/items/mark_incomplete/:id' => 'items#mark_incomplete'
  post '/lists/:list_id/items/sort' => 'todos#sort'

  root 'lists#index'

end
