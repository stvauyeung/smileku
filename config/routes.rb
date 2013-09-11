FirstBook::Application.routes.draw do
  root to: 'stories#index'
  
  get 'ui(/:action)', controller: 'ui'
  
  get '/registration', to: 'users#new'
  resources :users, :only => [:create, :show]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :stories, :except => [:destroy] do
  	resources :kus, :only => [:show]
  end
  resources :signups, :only => [:new, :create]
end
