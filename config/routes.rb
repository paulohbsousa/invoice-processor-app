Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :invoices do
    resources :line_items
  end

  post "invoices/next", to: "invoices#next"
  post "invoices/previous", to: "invoices#previous"

  get "bookings/search", to: "bookings#search", as: :bookings_search
end
