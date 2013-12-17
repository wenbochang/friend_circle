SocialThingamajig::Application.routes.draw do

  get "/users/forgot_password", to: "users#forgot_password"
  post "users/send_reset_email", to: "users#send_reset_email"

  get "/users/reset_page", to: "users#reset_page"
  post "users/reset_password", to: "users#reset_password"

  resources :users

  resource :session


end
