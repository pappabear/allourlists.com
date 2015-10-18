Rails.application.routes.draw do


  resources :lists do
    resources :items
  end

  put '/lists/:list_id/items/mark_complete/:id' => 'items#mark_complete'
  put '/lists/:list_id/items/mark_incomplete/:id' => 'items#mark_incomplete'
  post '/lists/:list_id/items/sort' => 'items#sort'
  post '/lists/:id/copy' => 'lists#copy'
  get '/lists/:list_id/items/mark_complete/:id' => 'items#mark_complete'
  get '/lists/:list_id/items/mark_incomplete/:id' => 'items#mark_incomplete'
  get '/feedback_emails/' => 'feedback_emails#new'


end
