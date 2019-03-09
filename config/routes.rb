Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/login", to: "page#login_page"
  post "/login", to: "page#login"
  get "/sign_up", to: "page#sign_up_page"
  post "/sign_up", to: "page#sign_up"
  get "/profile", to: "page#profile"
  patch "/profile", to: "page#profile_update"
  get "/log_out", to: "page#log_out"
  get "/forgot_password", to: "page#forgot_password_page"
  post "/forgot_password", to: "page#forgot_password"
  get "/reset_password", to: "page#reset_password_page"
  patch "/reset_password", to: "page#reset_password"
  root "page#login_page"
end
