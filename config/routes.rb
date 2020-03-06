Rails.application.routes.draw do
  resources :slices
  root to: 'home#index'
end
