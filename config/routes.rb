Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }
  devise_scope :user do
    delete 'users/remove_image' => 'users/registrations#remove_image'
    post 'users/upload_image' => 'users/registrations#upload_image'
  end

  # resources :users, only: [] do
  #   delete 'users/remove_image', on: :member, to: 'users/registrations#remove_image'
  # end
  resources :meal_plans
  resources :quantity_units
  resources :ingredients
  resources :recipes
  get 'menu' => 'access#menu'
  get 'login' => 'access#new'
  delete 'logout' => 'access#destroy'
  resource :access, controller: 'access', only: [:new, :create, :destroy] do
    member do
      get :menu
    end
  end
  root "meal_plans#index"
  # get "/", to: "homepage#home", as: "root"
  #

  match 'about', to: "main#about", via: :get

  # get 'main/index'
  # get 'main/about'

  resources :categories do
    member do
      get :delete
    end
  end

  resources :tasks do
    member do
      get :delete
    end
  end

  # get 'tasks/index'
  # get 'tasks/show'
  # get 'tasks/new'
  # get 'tasks/edit'
  # get 'tasks/delete'
  # get 'categories/index'
  # get 'categories/show'
  # get 'categories/new'
  # get 'categories/edit'
  # get 'categories/delete'

  # get 'homepage/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
