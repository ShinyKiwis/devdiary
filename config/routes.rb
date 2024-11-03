Rails.application.routes.draw do
  root to: 'bugs#index'
  resources :bugs
end
