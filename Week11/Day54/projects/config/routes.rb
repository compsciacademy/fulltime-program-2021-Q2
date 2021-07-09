Rails.application.routes.draw do
  root to: "projects#index"
  
  devise_for :users
  resources :projects do
    resources :discussions do
      resources :comments
    end
  end
end
