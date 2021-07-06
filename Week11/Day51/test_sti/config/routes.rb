Rails.application.routes.draw do
  root to: "discussions#index"

  resources :discussions do
    resources :comments
  end
end
