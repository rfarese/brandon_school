Rails.application.routes.draw do
  devise_for :users
  root to: "homes#index"
  resources :tours, only: [:new, :create]
  resource :qrcode_scans, only: [:new]
  resources :rooms, only: [:new, :create]
  resources :student_checks, only: [:update]
  resources :houses, only: [:index, :new, :create, :show]

  post 'generate_student_checks' => 'student_checks#new'
end
