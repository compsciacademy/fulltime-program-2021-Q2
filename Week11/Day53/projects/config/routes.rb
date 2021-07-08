Rails.application.routes.draw do
  root to: "projects#index"
  
  resources :projects do
    resources :discussions do
      resources :comments
    end
  end
end
