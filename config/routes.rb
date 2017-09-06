Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#index'
  resources :trainees do
    post 'toggle_tracking_status', to: 'trainees#toggle_tracking_status'
    resources :submissions
    resources :tracked_verdict
  end
end
