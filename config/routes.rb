Rails.application.routes.draw do
  
  resources :tweets
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  
  # get 'sessions/new'
  # get 'page/home'
  root 'page#home'
  get 'signup' => 'users#new'
  get 'signin' => 'sessions#new'
  delete 'signout' => 'sessions#destroy'
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
