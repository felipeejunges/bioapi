# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :basic_health_units
      match 'find_ubs' => 'basic_health_units#find_ubs', via: [:get]
    end
  end
  # mount Rswag::Ui::Engine  => '/api/docs'
  # mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
