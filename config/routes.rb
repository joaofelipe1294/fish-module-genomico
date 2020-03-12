Rails.application.routes.draw do
  resources :scannings
  resources :fish_slices
  get 'fish-slice/:id/scannings', to: 'fish_slices#scannings', as: :scannings_from_fish_slice
  get 'exam/:id/slices', to: 'fish_slices#slices_from_exam', as: :slices_from_exam
  root to: 'home#index'
end
