Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :index]
      resource :session, only: [:create, :new, :destroy]
      resources :transactions, only: [:create]
    end
  end
end
