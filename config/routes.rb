FirstBook::Application.routes.draw do
  root to: 'stories#index'
  
  get 'ui(/:action)', controller: 'ui'
  
  get '/registration', to: 'users#new'
  resources :users, :except => [:destroy] do
    member do
      get :following, :followers
    end
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/forgot_password', to: 'forgot_passwords#new', as: 'forgot_password'
  resources :forgot_passwords, :only => [:create]
  resources :password_resets, :only => [:show, :create]
  get '/expired_reset', to: 'password_resets#expired'

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

  resources :posts, :except => [:destroy]
  
  resources :signups, :only => [:new, :create]
  resources :invites, :only => [:new, :create]
  resources :followings, :only => [:create, :destroy]
  resources :listings, :only => [:create, :destroy]
end
