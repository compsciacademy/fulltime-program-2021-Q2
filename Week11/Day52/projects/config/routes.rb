Rails.application.routes.draw do
  root to: "projects#index"
  resources :projects 
  resources :discussions do
    resources :comments
  end
end
