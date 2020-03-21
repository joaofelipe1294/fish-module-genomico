require 'sidekiq/web'

Rails.application.routes.draw do
  resources :scanning_images
  resources :scannings
  resources :fish_slices
  resources :scanned_cells, only: [:show]
  patch 'scanned_cells/:id/change_label', to: 'scanned_cells#change_label', as: :change_cell_label
  get 'scanned_cells/treat/:id', to: 'scanned_cells#treat', as: :treat_scanned_cell
  get 'scanning-images/processing-progress', to: 'scanning_images#processing_progress', as: :processing_progress
  get 'scanning-images/complete', to: 'scanning_images#complete', as: :complete_scaning_images
  get 'fish-slice/:id/scannings', to: 'fish_slices#scannings', as: :scannings_from_fish_slice
  get 'exam/:id/slices', to: 'fish_slices#slices_from_exam', as: :slices_from_exam
  get 'scanning-images/processing', to: 'scanning_images#processing', as: :processing
  root to: 'home#index'
  mount Sidekiq::Web => '/sidekiq'
end
