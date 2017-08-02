Rails.application.routes.draw do
  
  resources :users do
    member do
      get :following, :followers
    end 
  end

  resources :tweets, only: [:create, :destroy, :edit, :show]
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships, :only => [:create, :destroy]

  # get 'sessions/new'
  # get 'page/home'
  root 'page#home'
  get 'signup' => 'users#new'
  get 'signin' => 'sessions#new'
  delete 'signout' => 'sessions#destroy'
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
