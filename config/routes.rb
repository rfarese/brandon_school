Rails.application.routes.draw do
  devise_for :users
  root to: "homes#index"
  resources :tours, only: [:new, :create]
  resource :qrcode_scan, only: [:new]
  resources :rooms, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :student_checks, only: [:create]
    end
  end

  post 'generate_student_checks' => 'api/v1/student_checks'
  resources :student_checks, only: [:new]
end
