Rails.application.routes.draw do
  root 'pages#index'

  namespace :api do
    namespace :v1 do
      resources :books, only: %i[index show create destroy], param: :slug
      resources :authors, only: %i[index show create destroy], param: :slug
      resources :genres, only: %i[index show create destroy], param: :slug
    end
  end

  get '*path', to: 'pages#index', via: :all
end
