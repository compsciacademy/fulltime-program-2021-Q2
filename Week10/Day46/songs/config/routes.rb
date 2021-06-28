Rails.application.routes.draw do
  resources :users
  resource :user_session
end
