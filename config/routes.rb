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
  resources :reports, only: [:index]

  get 'report_filters' => "reports#filters"
  post 'generate_student_checks' => 'student_checks#new'
  post 'new_qrcode' => 'rooms#new_qrcode'
end
