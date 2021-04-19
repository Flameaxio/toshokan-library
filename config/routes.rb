Rails.application.routes.draw do
  constraints subdomain: '' do
    root 'pages#index'
  end

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
        get :subscription, to: 'sessions#subscription'
      end
      resources :subscriptions, only: %i[index]
      post :subscribe, to: 'subscriptions#subscribe'
    end
  end

  constraints subdomain: 'admin' do
    get '/', to: 'dashboard#dashboard'
    get '/books', to: 'dashboard#books'
    post '/search', to: 'dashboard#search'
    get '/import', to: 'import#index'
    post '/import', to: 'import#create'
    resources :books, except: %i[show index]
  end

  get '*path', to: 'pages#index', via: :all
end
