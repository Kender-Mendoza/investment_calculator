Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "calculator#index"
  post "/calculate", to: "calculator#calculate"
  get "/print_projection", to: "calculator#print_projection", defaults: { :format => "csv" }
end
