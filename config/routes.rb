Rails.application.routes.draw do
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "movies#index"
  resources :movies do
    resources :reviews
  end
  
  get "/signup", to: 'users#new', as: 'signup'

  resource :session, only: [:new, :create, :destroy]

end
