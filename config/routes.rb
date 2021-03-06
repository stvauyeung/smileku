FirstBook::Application.routes.draw do
  root to: 'statics#home'
  
  get 'ui(/:action)', controller: 'ui'
  get 'sitemap.xml', to: 'sitemap#index', as: 'sitemap', defaults: { format: 'xml' }

  get '/registration', to: 'users#new', as: 'registration'
  resources :users, :except => [:destroy] do
    member do
      get :following, :followers, :listings
    end
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/forgot_password', to: 'forgot_passwords#new', as: 'forgot_password'
  resources :forgot_passwords, :only => [:create]
  resources :password_resets, :only => [:show, :create]
  get '/expired_reset', to: 'password_resets#expired'

  match '/home', to: 'statics#home', as: 'home'
  match '/front', to: 'statics#front'
  match '/contact', to: 'statics#contact', as: 'contact'
  match '/faq', to: 'statics#faq', as: 'faq'
  match '/terms', to: 'statics#terms', as: 'terms'

  resources :stories, :except => [:destroy] do
  	resources :kus, :only => [:new, :create]
  end

  resources :kus, :only => [:show, :edit, :update] do
    resources :comments, only: [:new, :create]
    
    member do
      post 'vote'
    end
  end

  resources :posts, :except => [:destroy], path: "writing-tips"
  
  resources :signups, :only => [:new, :create]
  resources :invites, :only => [:new, :create]
  resources :followings, :only => [:create, :destroy]
  resources :listings, :only => [:create, :destroy]
end
