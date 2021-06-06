Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :admin, only: [:index]

  namespace :admin do
   resources :merchants, except: [:delete, :put]
   resources :invoices, only: [:index, :show]
   patch '/merchants', to: 'merchants#update_status'
  end

  resources :merchants, only: [:show] do
    get '/dashboard', to: 'dashboard#show'
    resources :invoices, only: [:show]
    scope module: :merchants do
      resources :items
      resources :invoices, only: [:index]
    end
  end
end
