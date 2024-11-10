# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'bugs#index'
  resources :bugs do
    patch :investigate, on: :member
    patch :resolve, on: :member
    patch :close, on: :member
    get :resolving , on: :member
  end
end
