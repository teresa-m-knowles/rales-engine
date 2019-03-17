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
        get '/revenue', to: 'revenue#show'
        get '/:id/revenue', to: 'revenue#show'
        get '/:id/favorite_customer', to: 'favorite_customer#show'
      end

      namespace :items do
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/:id/best_day', to: 'best_day#show'
      end

      namespace :customers do
        get '/:id/favorite_merchant', to: 'favorite_merchant#show'
      end

      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/:invoice_id/customer', to: 'customer#show'
        get '/:invoice_id/merchant', to: 'merchant#show'
      end

      namespace :invoice_items do
        get '/:invoice_item_id/invoice', to: 'invoice#show'
        get '/:invoice_item_id/item', to: 'item#show'
      end

      resources :transactions, only: [:index, :show]

      resources :invoice_items, only: [:show, :index]

      resources :invoices, only: [:index, :show] do
        resources :transactions, only: [:index], module: 'invoices'
        resources :invoice_items, only: [:index], module: 'invoices'
        resources :items, only: [:index], module: 'invoices'
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
