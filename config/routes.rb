Rails.application.routes.draw do
  root 'pages#index'

  namespace :api do
    namespace :v1 do
      resources :books, only: %i[index show create destroy], param: :slug do
        post :buy
        get :check_ownership
      end
      resources :authors, only: %i[index show create destroy], param: :slug
      resources :genres, only: %i[index show create destroy], param: :slug
      resource :searches, except: %i[new create edit update destroy] do
        get :types
        get :search
      end
      namespace :users do
        resources :sessions, only: %i[create]
        resources :registrations, only: %i[create]
        delete :logout, to: 'sessions#logout'
        get :logged_in, to: 'sessions#logged_in'
      end
    end
  end

  get '*path', to: 'pages#index', via: :all
end
