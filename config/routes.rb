Rails.application.routes.draw do
  # Set default page to users index
  root 'api/v1/users#index'

  # Created nested routes by way of namespacing
  namespace :api do
    namespace :v1 do
      #Create routes only for certain methods
      resources :users, only: [:create, :index, :new]
      resource :session, only: [:create, :new, :destroy]
      resources :transactions, only: [:create, :index]
      #Create JSON route in order for JBuilder to render JSON
      defaults format: :json do
        get 'users/current', :to => 'users#current'
      end
    end
  end
end
