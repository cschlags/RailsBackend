Rails.application.routes.draw do
  root "application#index"

    resources :user
    resources :like
    resources :outfit

    get 'auth/:provider/callback', to: 'sessions#create'
    get 'auth/failure', to: redirect('/')
    get 'signout', to: 'sessions#destroy', as: 'signout'

end
