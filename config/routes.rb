Rails.application.routes.draw do
  get 'scannings/index'
  get 'scannings/new'
  resources :fish_slices
  get 'exam/:id/slices', to: 'fish_slices#slices_from_exam', as: :slices_from_exam
  root to: 'home#index'
end
