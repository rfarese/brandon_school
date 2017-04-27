Rails.application.routes.draw do
  devise_for :users
  root to: "homes#index"

  namespace :qrcodes do
    get 'scan'
    post 'replace'
  end

  resources :rooms

  namespace :student_checks do
    post 'edit'
    patch 'update'
  end

  resources :houses
  resources :beds
  resources :reports, only: [:index]

  resources :selfies, only: [:new, :create] do
    resources :tours, only: [:new, :create]
  end

  get 'report_filters' => "reports#filters"
  post 'new_notification' => 'notification_emails#new'
  get 'tours_in_progress' => 'tours_in_progress#index'

  namespace :api do
    namespace :v1 do
      get 'tours_in_progress' => 'tours_in_progress#index'
    end
  end
end
