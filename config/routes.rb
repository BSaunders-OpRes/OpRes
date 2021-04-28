Rails.application.routes.draw do
  devise_scope :user do
    root 'users/sessions#new'
  end

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
    resources :institutions
    resources :products
    resources :channels
    resources :journeys,  only: %i[show] do
      post :show, on: :member
    end
    resources :business_service_lines
    resources :suppliers
    resources :organisation_admins
    resources :unit_admins
  end
end
