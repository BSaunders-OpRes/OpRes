Rails.application.routes.draw do
  root 'visitor#index'

  devise_for :users, controllers: {
    sessions:        'users/sessions',
    registrations:   'users/registrations',
    authentications: 'users/authentications',
    passwords:       'users/passwords'
  }

  namespace :admin do
    resources :dashboard, only: %i[index]
    resources :institutions
    resources :products
    resources :channels
  end
end
