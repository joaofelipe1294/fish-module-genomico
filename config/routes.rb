require 'sidekiq/web'

Rails.application.routes.draw do
  resources :scanning_images
  resources :scannings
  resources :fish_slices
  resources :scanned_cells
  get 'scanned_cells/treat/:id', to: 'scanned_cells#treat', as: :treat_scanned_cell
  get 'fish-slice/:id/scannings', to: 'fish_slices#scannings', as: :scannings_from_fish_slice
  get 'exam/:id/slices', to: 'fish_slices#slices_from_exam', as: :slices_from_exam
  get 'scanning-images/processing', to: 'scanning_images#processing', as: :processing
  root to: 'home#index'
  mount Sidekiq::Web => '/sidekiq'
end
