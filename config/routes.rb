Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root controller: :conversations, action: :index
  mount ActionCable.server => '/cable'
  post '/conversation', to: 'conversations#create'
  get '/conversation/:id', to: 'conversations#show'
  patch '/conversation/:id', to: 'conversations#update'
  delete '/conversation/:id', to: 'conversations#destroy'
  get '/conversations', to: 'conversations#index'

  post '/message', to: 'messages#create'
  get '/message/:id', to: 'messages#show'
  patch '/message/:id', to: 'messages#update'
  delete '/message/:id', to: 'messages#destroy'
  get '/messages', to: 'messages#index'

  post '/user', to: 'users#create'
  get '/user/:id', to: 'users#show'
  patch '/user/:id', to: 'users#update'
  delete '/user/:id', to: 'users#destroy'
end
