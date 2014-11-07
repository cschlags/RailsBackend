Rails.application.routes.draw do
  root "application#index"

    resources :user
    resources :like
    resources :outfit

  get '/auth/facebook', as: "facebook_login"
  match 'auth/facebook/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  get 'logout' => 'sessions#destroy', :as => :logout

end
