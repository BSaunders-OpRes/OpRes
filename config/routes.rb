Rails.application.routes.draw do
  root 'visitor#index'

  devise_for :users, controllers: {
    sessions:        'users/sessions',
    registrations:   'users/registrations',
    authentications: 'users/authentications',
    passwords:       'users/passwords',
    confirmations:   'users/confirmations'
  }

  namespace :admin do
    resources :dashboard, only: %i[index]
    resources :institutions
    resources :products
    resources :channels
  end

  namespace :organisation do
    resources :dashboard, only: %i[index]
    resources :journeys, only: %i[index] do
      patch :regional_step,    on: :collection
      post :country_step,     on: :collection
      post  :institution_step, on: :collection
      post  :product_step,     on: :collection
      post  :channel_step,     on: :collection
    end
    resources :business_service_lines
    resources :suppliers
  end
end
