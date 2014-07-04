Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  mount Sidekiq::Web => "/sidekiq"

  resources :policies
  resources :openings
  resources :notices
  resources :users

  root 'welcome#index'

  scope '/auth' do
    get '/:provider/callback',       to: 'sessions#create'
    get '/failure',                  to: 'sessions#failure'
    get '/destroy_session',          to: 'sessions#destroy',  as: :logout
    # get '/login/:provider',          to: 'sessions#auth',     as: :auth
    get '/offline_login/:nickname',  to: 'sessions#offline_login' if Rails.env.development?
  end

  match 'styleguide', via: :get, to: "styleguide#index"
  match 'ping', via: :get, to: -> (env) { [418, {"Content-Type" => "text/html"}, ["pong"]] }
end
