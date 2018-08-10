Rails.application.routes.draw do
  get  "/thank-you" => "main#thank_you"
  post "/loans" => "loans#create"
  root "main#home"
end
