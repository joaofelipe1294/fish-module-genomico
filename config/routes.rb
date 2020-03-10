Rails.application.routes.draw do
  resources :scannings
  resources :fish_slices
  get 'exam/:id/slices', to: 'fish_slices#slices_from_exam', as: :slices_from_exam
  root to: 'home#index'
end
