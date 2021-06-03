Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants, only: :show do
    scope module: :merchants do
      resources :items, only: [:index, :show]
    end
  end

  resources :merchants, only: [:show] do
    get '/dashboard', to: 'dashboard#show'
  end
end
