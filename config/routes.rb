Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    confirmations: 'confirmations'
  }

  resources :profiles, only: [:new, :create]

  get "/queue", to: 'requests#queue'
  get "/confirmation_queue", to: 'requests#confirmation_queue'

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

