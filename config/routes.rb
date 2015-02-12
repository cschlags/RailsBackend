Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => 'omniauth_callbacks'}
  use_doorkeeper
  root to: "application#index"
  get 'work' => 'application#work', :as => :work
  get 'about' => 'application#about', :as => :about

    resources :user
    resources :wardrobe
    resources :like
    resources :outfit

  # get '/auth/facebook', :as => 'application#signin', as: 'signin'
  # match 'auth/facebook/callback', to: 'sessions#create', via: [:get, :post]
  # match 'auth/failure', to: redirect('/'), via: [:get, :post]
  # get 'signin' => 'application#signin', :as => :signin
  get   '/login', :to => 'sessions#new', :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create', via: [:get, :post]
  match '/auth/failure', :to => 'sessions#failure', via: [:get, :post]
  get 'logout' => 'sessions#destroy', :as => :logout
  
  namespace :api do
    namespace :v1 do
      resources :tokens,:only => [:create, :destroy]
      resources :user, via:[:get, :post]
      resources :wardrobe, via:[:get, :post]
      resources :like, via:[:get, :post]
      resources :outfit, via:[:get, :post]
      resources :batch
    end
  end
end