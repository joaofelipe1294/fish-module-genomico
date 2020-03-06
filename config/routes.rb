Rails.application.routes.draw do
  resources :slices
  get 'exam/:id/slices', to: 'slices#from_exam', as: :slices_from_exam
  root to: 'home#index'
end
