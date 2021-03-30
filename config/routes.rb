Rails.application.routes.draw do
  resources :business_service_lines
  resources :channels
  resources :products
  resources :organisational_units
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
