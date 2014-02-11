Citibike::Application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  get '/buy/:id', to: 'transactions#new', as: :show_buy
  post '/buy/:id', to: 'transactions#create', as: :buy
  get '/pickup/:guid', to: 'transactions#pickup', as: :pickup
  get '/download/:guid', to: 'transactions#download', as: :download
  match '/iframe/:id' => 'transactions#iframe', via: :get, as: :buy_iframe
  get '/payments', to: 'payments#new'
  post '/payments', to: 'payments#create'
  get '/payments/confirm', to: 'payments#confirm'
  get '/transfers', to: 'transfers#new'
  post '/transfers', to: 'transfers#create'
  get '/transfers/confirm', to: 'transfers#confirm'

  # stripe connect
  get '/auth/stripe_connect/callback', to: 'stripe_connect#create'

  resources :stripe_events, only: [:create]
  resources :sales
  resources :customers

  get "comments/index"
  get "comments/new"
  resources :searches, only: [:new, :create, :index]
  resources :exchanges  do
    member do
      put 'claim'
      put 'confirm'
    end
    resources :comments
  end

  devise_for :users, :path => "auth", :path_names => { :sign_in => 'login', :sign_out => 'logout' }, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :users do
    resources :comments
    resources :favorites
      member do
        post 'favorite'
      end   
  end
  
  get 'account' => 'welcome#account'
  root 'welcome#index'
  # resource :session, only: [:destroy, :create, :new]

end
