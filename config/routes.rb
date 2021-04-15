Rails.application.routes.draw do
  root 'visitor#index'

  devise_for :users, controllers: {
    sessions:        'users/sessions',
    registrations:   'users/registrations',
    authentications: 'users/authentications',
    passwords:       'users/passwords'
  }
end
