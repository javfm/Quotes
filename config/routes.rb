Rails.application.routes.draw do
  root 'quotes#index'
  get '/:pag', to: 'quotes#index', as:'pagination'

  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :quotes do
      delete 'delete_relation', on: :member, to: 'quotes#delete_relation'
      patch 'add_relation', on: :member, to: 'quotes#add_relation'
  end
  resources :users do
    resources :lists
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
