Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants, except: [:delete, :put]
  end

  resources :merchants, only: [:show] do
    scope module: :merchants do
      resources :items, except: [:delete, :create]
    end
  end
end
