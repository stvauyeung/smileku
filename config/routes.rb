FirstBook::Application.routes.draw do
  root to: 'stories#index'
  
  get 'ui(/:action)', controller: 'ui'
  
  get '/registration', to: 'users#new'
  resources :users, :except => [:destroy]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  match '/front', to: 'statics#front'
  match '/contact', to: 'statics#contact'

  resources :stories, :except => [:destroy] do
  	resources :kus, :only => [:new, :create]
  end

  resources :kus, :only => [:show, :edit, :update] do
    resources :comments, only: [:new, :create]
    
    member do
      post 'vote'
    end
  end
  
  resources :signups, :only => [:new, :create]
end
