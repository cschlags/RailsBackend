Rails.application.routes.draw do
  use_doorkeeper
  root :to => "application#index"
  get 'work' => 'application#work', :as => :work
  get 'about' => 'application#about', :as => :about

    resources :user
    resources :wardrobe
    resources :like
    resources :outfit

  get '/auth/facebook', as: "facebook_login"
  match 'auth/facebook/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  get 'logout' => 'sessions#destroy', :as => :logout
  get 'signin' => 'application#signin', :as => :signin
  
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :user do
        resources :wardrobe
        resources :like
        resources :outfit
      end
      resources :batch
    end
  end
end
