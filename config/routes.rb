FirstBook::Application.routes.draw do
  root to: 'users#new'
  
  resources :stories, :except => [:destroy]
  resources :users, :only => [:new, :create]
end
