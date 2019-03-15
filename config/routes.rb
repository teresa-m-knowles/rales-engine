Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/:id/revenue', to: 'revenue#show'
        get '/:id/favorite_customer', to: 'favorite_customer#show'
      end

      namespace :items do
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/:id/best_day', to: 'best_day#show'
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], module: 'merchants'
        resources :invoices, only: [:index], module: 'merchants'
      end
      resources :customers, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoiceitems, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :transactions, only: [:index, :show]

    end
  end

end
