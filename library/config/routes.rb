Rails.application.routes.draw do

  root controller: :product, action: :list
  
  get 'user/new'
  post 'user/create'
  #get 'sessions/new'
  ##get 'sessions/create'
  #get 'sessions/login'
  #get 'sessions/welcome'
  post 'logout', to: 'sessions#destroy' 

  #devise_for :user
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get 'product/list'
  get 'category/list'

  get 'product/payment', to: 'product#initiatePayment'
  get 'product/show/:id', to: 'product#show'
  get 'product/:id', to: 'product#show', as:'product'
  
  post 'order/confirm'


  #define API for ajax calls
  resources :product do
  	collection do
  		post 'search'
      post 'calculateValue'
      post 'paypal-transaction-complete', to: 'product#complete_payment'
  	end	
  end

  resources :user, only: [:new, :create]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'

  get 'authorized', to: 'sessions#page_requires_login'

  post 'process_payment', to:'order#process_payment'

  ##admin routes
  namespace :admin do
    
    post  'adminlogout', to: 'user#logout'
    
    #user verbs
    get   'user/list', to: 'user#list'
    get   'user/new', to: 'user#new'
    post  'user/create', to: 'user#create'
    get   'user/edit/:id', to: 'user#edit'
    patch 'user/update/:id', to: 'user#update'
    get   'user/delete/:id', to: 'user#destroy'

    #product verbs
    get   'product/list', to: 'product#list'
    get   'product/new', to: 'product#new'
    post  'product/create', to: 'product#create'
    get   'product/edit/:id', to: 'product#edit'
    patch 'product/update/:id', to: 'product#update'
    post  'product/create', to: 'product#create'
    get   'product/delete/:id', to: 'product#destroy'
  end
end