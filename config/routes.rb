Rails.application.routes.draw do
  resources :users

  ActiveAdmin.routes(self)
  mount Sidekiq::Web => "/sidekiq"

  root 'welcome#index'

  match 'ping', via: :get, to: -> (env) { [418, {"Content-Type" => "text/html"}, ["pong"]] }
end
