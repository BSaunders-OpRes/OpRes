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
    match '/journeys/*id',      to: 'journeys#show', via: %i[get post], as: :journey
    get :build_institution,     to: 'journeys#build_institution'
    get :build_user_invitation, to: 'journeys#build_user_invitation'
    resources :dashboard, only: %i[index]
    resources :accounts, only: %i[index] do
      post :save_account, on: :collection
    end
    resources :graphs, only: %i[show]
    resources :institutions
    resources :products
    resources :channels
    resources :business_service_lines do
      get :compound_resilience,          on: :collection
      get :cloud_service_provider,       on: :collection
      get :critical_important_suppliers, on: :collection
    end
    resources :suppliers
    resources :unit_hierarchys, only: %i[] do
      get :load_countries,         on: :collection
      get :load_institutions,      on: :collection
      get :load_products_channels, on: :collection
    end
    resources :cloud_hosting_providers, only: %i[] do
      get :regions_services, on: :member
    end
    resources :admins
    resources :administration_portal, only: %i[index]
    # resources :supplier_contacts
    resources :key_contacts
    resources :steps, only: %[destroy] do
      delete :supplier_step, on: :member
    end
  end
end
