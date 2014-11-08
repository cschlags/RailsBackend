Rails.application.routes.draw do
  root "application#index"

    resources :user
    resources :like
    resources :outfit

  get '/auth/facebook', as: "facebook_login"
  match 'auth/facebook/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  get 'logout' => 'sessions#destroy', :as => :logout

  namespace :api, path: '', constraints: {subdomain: 'api'} do
    namespace :v1 do
      resources :users
    end
  end
end
