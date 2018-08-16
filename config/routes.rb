Rails.application.routes.draw do
  get  "/thank-you" => "main#thank_you"
  get  "/rates" => "loans#rates"
  get  "/sorry" => "main#sorry"
  post "/select_rate" => "loans#select_rate"
  post "/loans" => "loans#create"
  root "main#home"
end
