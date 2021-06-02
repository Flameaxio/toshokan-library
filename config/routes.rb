Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :users do
        get :logged_in, to: 'sessions#logged_in'
      end
      resources :messages, only: %i[create]
    end
  end

  constraints subdomain: '' do
    get '/confirm/:id', to: 'users#confirm'
    root 'pages#index'
  end

  namespace :api do
    namespace :v1 do
      resources :books, only: %i[index show create destroy], param: :slug do
        post :buy
        get :check_ownership
        get :read
      end
      resources :authors, only: %i[index show create destroy], param: :slug
      resources :genres, only: %i[index show create destroy], param: :slug
      resources :messages, only: %i[index]
      resource :searches, except: %i[new create edit update destroy] do
        get :types
        get :search
      end
      namespace :users do
        resources :sessions, only: %i[create]
        resources :registrations, only: %i[create]
        delete :logout, to: 'sessions#logout'
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
    get '/login', to: 'users#show'
    post '/authenticate', to: 'users#authenticate'
    resources :books, except: %i[show index]
    resources :chats, only: %i[index show]
    get '/feedback', to: 'chats#index'
  end

  mount ActionCable.server => '/cable'
  get '*path', to: 'pages#index', via: :all
end
