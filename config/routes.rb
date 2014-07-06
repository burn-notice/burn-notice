Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  mount Sidekiq::Web => "/sidekiq"

  resources :notices do
    resources :openings
  end
  resources :users
  resources :policies

  scope '/p' do
    get  '/open/:token',  to: 'public#open', as: :open
    post '/read',         to: 'public#read', as: :read
  end

  scope '/auth' do
    get '/offline_login/:nickname',  to: 'sessions#offline_login' if Rails.env.development?
    get '/:provider/callback',       to: 'sessions#create'
    get '/failure',                  to: 'sessions#failure'
    get '/destroy_session',          to: 'sessions#destroy',  as: :logout
    get '/validation/:token',        to: 'sessions#validation', as: :validation
  end

  root 'welcome#index'

  match 'styleguide', via: :get, to: "styleguide#index"
  match 'ping', via: :get, to: -> (env) { [418, {"Content-Type" => "text/html"}, ["pong"]] }
end
