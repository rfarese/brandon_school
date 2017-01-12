Rails.application.routes.draw do
  devise_for :users
  root to: "homes#index"
  resources :tours, only: [:new, :create]
  resource :qrcode_scan, only: [:new]
  resources :rooms, only: [:new, :create]
end
