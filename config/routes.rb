# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'bugs#index'
  resources :bugs
end
