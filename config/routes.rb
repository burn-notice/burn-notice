Rails.application.routes.draw do
  resources :policies

  resources :openings

  resources :notices

  resources :users

  ActiveAdmin.routes(self)
  mount Sidekiq::Web => "/sidekiq"

  root 'welcome#index'

  match 'ping', via: :get, to: -> (env) { [418, {"Content-Type" => "text/html"}, ["pong"]] }
end
