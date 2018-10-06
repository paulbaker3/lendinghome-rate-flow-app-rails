Rails.application.routes.draw do
  # I added these named routes back in after converting everything to RESTful routes
  # It is possible to use named routes in Rails. However, it requires the developer
  # to pass all view variables as locals rather than instance vars from the
  # controller. I reached for it at the end in an attempt to preserve the orginal
  # look and feel of the routes. I'm a believer that routes should be RESTful unless
  # there's an extremely compelling reason for the contrary.
  #
  # Route aesthetics is an important design feature. It's just possible to achieve
  # that without departing from REST.
  get "/welcome" => "users#new", as: "welcome"
  get "/loan-selection" => "users#edit", as: "load_selection"
  get "/thank-you" => "loans#show", as: "thank_you"

  resources :users, only: [:create, :edit, :new, :update]
  resources :loans, only: [:show]
  root "users#new"
end
