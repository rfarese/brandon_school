Rails.application.routes.draw do
  devise_for :users
  root to: "homes#index"
  resources :tours, only: [:new, :create]
  resource :qrcode_scan, only: [:new]
  resources :rooms, only: [:new, :create]
  resource :student_check, only: [:new]

  post 'generate_student_checks' => 'api/v1/student_checks#generate'
  put 'update_student_checks' => 'api/v1/student_checks#update'
end
