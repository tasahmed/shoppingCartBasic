Rails.application.routes.draw do

  namespace :admin do
    get 'user/list'
  end
  root controller: :product, action: :list
  

  get 'user/new'
  post 'user/create'
  #get 'sessions/new'
  ##get 'sessions/create'
  #get 'sessions/login'
  #get 'sessions/welcome'
  post 'logout', to: 'sessions#destroy' 

  devise_for :user
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get 'product/list'
  get 'category/list'

  get 'product/show/:id', to: 'product#show'
  get 'product/:id', to: 'product#show', as:'product'
  
  post 'order/confirm'

  #define API for ajax calls
  resources :product do
  	collection do
  		post 'search'
      post 'calculateValue'
  	end	
  end

  resources :user, only: [:new, :create]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'

  get 'authorized', to: 'sessions#page_requires_login'

  ##admin routes
  namespace :admin do
    get 'user/list', to: 'user#list'
    post 'adminlogout', to: 'user#logout'
    get 'user/new', to: 'user#new'
    post 'user/create', to: 'user#create'
  end
end