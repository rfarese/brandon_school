Rails.application.routes.draw do
  devise_for :users
  root to: "homes#index"
  resource :qrcode_scans, only: [:new]
  resources :rooms
  resources :student_checks, only: [:update]
  resources :houses
  resources :beds
  resources :students
  resources :reports, only: [:index]
  resources :selfies, only: [:new, :create] do
    resources :tours, only: [:new, :create]
  end

  get 'report_filters' => "reports#filters"
  post 'generate_student_checks' => 'student_checks#new'
  patch 'update_student_checks' => 'student_checks#update_all'
  post 'new_qrcode' => 'rooms#new_qrcode'
  post 'new_notification' => 'notification_emails#new'
  get 'tours_in_progress' => 'tours_in_progress#index'

  namespace :api do
    namespace :v1 do
      get 'tours_in_progress' => 'tours_in_progress#index'
    end
  end
end
