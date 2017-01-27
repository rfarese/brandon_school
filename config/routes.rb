Rails.application.routes.draw do
  devise_for :users
  root to: "homes#index"
  resources :tours, only: [:new, :create]
  resource :qrcode_scans, only: [:new]
  resources :rooms
  resources :student_checks, only: [:update]
  resources :houses
  resources :beds
  resources :students 

  post 'generate_student_checks' => 'student_checks#new'
end
