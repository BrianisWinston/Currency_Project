Rails.application.routes.draw do
  root 'api/v1/users#index'
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :index, :new]
      resource :session, only: [:create, :new, :destroy]
      resources :transactions, only: [:create]
    end
  end
end
