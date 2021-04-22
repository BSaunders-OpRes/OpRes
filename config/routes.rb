require 'subdomain_constraint'
require 'domain_constraint'

Rails.application.routes.draw do
  constraints DomainConstraint do
    root 'visitor#index'

    devise_for :users, controllers: {
      sessions:        'users/sessions',
      registrations:   'users/registrations',
      authentications: 'users/authentications',
      passwords:       'users/passwords'
    }

    resources :authentication, only: %i[index] do
      collection do
        post   :sign_in
        delete :sign_out
      end
    end

    namespace :admin do
      resources :dashboard, only: %i[index]
      resources :institutions
      resources :products
      resources :channels
    end
  end

  namespace :organisation do
    resources :dashboard, only: %i[index]
    resources :business_service_lines
    resources :suppliers
  end
end
