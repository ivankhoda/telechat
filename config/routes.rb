Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root controller: :conversations, action: :index

  post '/conversation', to: 'conversations#create'
  get '/conversation/:id', to: 'conversations#show'
  patch '/conversation/:id', to: 'conversations#update'
  delete '/conversation/:id', to: 'conversations#destroy'
  # get '/conversations', to: 'conversations#index'

  resources :messages
  resources :conversations
end
