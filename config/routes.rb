Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  mount Sidekiq::Web => "/sidekiq"

  resources :policies
  resources :openings
  resources :notices
  resources :users

  root 'welcome#index'

  match 'styleguide', via: :get, to: "styleguide#index"
  match 'ping', via: :get, to: -> (env) { [418, {"Content-Type" => "text/html"}, ["pong"]] }
end
