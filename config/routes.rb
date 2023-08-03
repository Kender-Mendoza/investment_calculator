Rails.application.routes.draw do
  root "calculator#index"
  post "/calculate", to: "calculator#calculate"
  post "/print_projection", to: "calculator#print_projection", defaults: { :format => "csv" }
  get "/projection", to: "calculator#projection"
end
