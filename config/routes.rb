Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users
  post "/auth/login", to: "authentication#login"
  get "/nasa/apod", to: "nasa#apod"
  get "/nasa/asteroid", to: "nasa#asteroid"
  resources :favorite
end
