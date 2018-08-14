Rails.application.routes.draw do
  root 'api/v1/users#index'
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :index, :new]
      resource :session, only: [:create, :new, :destroy]
      resources :transactions, only: [:create, :index]
      defaults format: :json do
        get 'users/current', :to => 'users#current'
      end
    end
  end
end
