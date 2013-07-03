FirstBook::Application.routes.draw do
  root to: 'signups#new'
  
  get 'ui(/:action)', controller: 'ui'
  
  get '/registration', to: 'users#new'
  resources :users, :only => [:create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :stories, :except => [:destroy]
  resources :signups, :only => [:new, :create]
end
