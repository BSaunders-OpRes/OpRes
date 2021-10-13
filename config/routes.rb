Rails.application.routes.draw do
  devise_scope :user do
    root 'users/sessions#new'
  end

  devise_for :users, controllers: {
    sessions:             'users/sessions',
    registrations:        'users/registrations',
    authentications:      'users/authentications',
    passwords:            'users/passwords',
    confirmations:        'users/confirmations',
    invite_confirmations: 'users/invite_confirmations'
  }


  resources :introjs, only: %i[index] do
    post :visited, on: :collection
  end

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
    resources :dashboard, only: %i[index show]


    resources :resilience_tickets do
      post :save_assignee_user, to: 'resilience_gaps#save_assignee_user'

      resources :resilience_gaps do
        get :resilience_indicator_ticket, on: :member
      end
    end

    resources :dashboard_break_downs, only: %i[] do
      get :business_service_tiers, on: :collection
      get :breakdown, on: :collection
      get :cloud_service_provider_breakdown, on: :collection
      get :critical_important_system, on: :collection
      get :impact_tolerance_appetite, on: :collection
      get :cloud_critical_system, on: :collection
      get :system_supplier_resilience_indicator, on: :collection
      get :impact_tolerance_breakdown, on: :collection
      get :cloud_service_provider_services, on: :collection
    end

    resources :accounts, only: %i[index] do
      post :save_account, on: :collection
    end
    resources :graphs, only: %i[] do
      get :compose, on: :collection
    end
    resources :resiliences, only: %i[index]
    resources :institutions do
      get :search_by_name, on: :collection
    end
    resources :products do
      get :search_by_name, on: :collection
    end
    resources :channels do
      get :search_by_name, on: :collection
    end
    resources :business_service_lines do
      get :critical_important_suppliers,    on: :member
      get :compound_resilience,             on: :member
      get :cloud_service_provider,          on: :member
      get :upload,                          on: :collection
      get :bsl_critical_important_supplier, on: :collection
      post :import,                          on: :collection
      get :find_chp_data,                   on: :collection
      get :find_compound_resilience_data,   on: :collection
    end
    resources :suppliers do
      get :all_suppliers, on: :collection
      get :critical_important_suppliers, on: :member
      get :compound_resilience,          on: :member
      get :search_and_filter,            on: :member
      get :upload,                       on: :collection
      post :import,                       on: :collection
      get :find_compound_resilience_data,   on: :collection
      resources :compliance_evidences do
        resources :compliance_rules
      end
    end
    resources :unit_hierarchys, only: %i[] do
      get :load_countries,         on: :collection
      get :load_institutions,      on: :collection
      get :load_products_channels, on: :collection
    end
    resources :cloud_hosting_providers, only: %i[] do
      get :regions_services, on: :member
    end
    resources :admins do
      get :search_by_name, on: :collection
    end
    resources :administration_portal, only: %i[index]
    # resources :supplier_contacts
    resources :key_contacts
    resources :steps, only: %[destroy] do
      delete :supplier_step, on: :member
    end
  end
end
