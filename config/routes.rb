SocialThingamajig::Application.routes.draw do

  get "/users/forgot_password", to: "users#forgot_password"
  post "users/send_reset_email", to: "users#send_reset_email"

  #get "/users/reset_page", to: "users#reset_page"
  get "users/reset_password_form", to: "users#reset_password_form"

  resources :users
  post "/posts/post_link", to: "posts#post_link", as: "post_link"

  resources :friend_circles


end
