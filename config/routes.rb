Rails.application.routes.draw do
  resources :notices do
    get :first_step, on: :collection
    post :first_step, on: :collection
    get :second_step, on: :member
    patch :second_step, on: :member
    get :third_step, on: :member
    patch :third_step, on: :member
    get :share, on: :member
    patch :share, on: :member
    patch :enable, on: :member
    patch :disable, on: :member
    patch :burn, on: :member
    post :bulk, on: :collection
  end
  resources :users do
    patch :confirmation_mail, on: :member
  end
  resources :articles
  resources :charges

  resource :sitemap, only: :show

  scope '/p' do
    get  '/open/:token',  to: 'public#open',  as: :open
    post '/read',         to: 'public#read',  as: :read
    get  '/read_public',  to: 'public#read_public' if Rails.env.development?
  end

  scope '/auth' do
    get  '/offline_login/:nickname', to: 'sessions#offline_login' if Rails.env.development?
    get  '/:provider/callback',      to: 'sessions#create',     as: :provider_callback
    get  '/failure',                 to: 'sessions#failure'
    get  '/destroy_session',         to: 'sessions#destroy',    as: :logout
    get  '/validation/:token',       to: 'sessions#validation', as: :validation
    get  '/signup',                  to: 'sessions#signup',     as: :signup
    get  '/ticket',                  to: 'sessions#ticket',     as: :ticket
    get  '/login',                   to: 'sessions#login',      as: :login
    get  '/email',                   to: 'sessions#email',      as: :email_login
    post '/complete',                to: 'sessions#complete',   as: :complete
  end

  scope '/sessions' do
    match '/email', to: 'sessions#email', via: [:get, :post]
  end

  root 'home#index'

  get '/blog',     to: 'articles#index'
  get '/faq',      to: 'home#faq'
  get '/pricing',  to: 'home#pricing'
  post '/donation',  to: 'home#donation'

  # dev
  get '/styleguide', to: 'styleguide#index'

  get '/ping', to: -> (env) { [200, {'Content-Type' => 'text/html'}, ['pong']] }
end
