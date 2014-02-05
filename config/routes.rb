Citibike::Application.routes.draw do
  get '/buy/:id', to: 'transactions#new', as: :show_buy
  post '/buy/:id', to: 'transactions#create', as: :buy
  get '/pickup/:guid', to: 'transactions#pickup', as: :pickup
  get '/download/:guid', to: 'transactions#download', as: :download
  match '/iframe/:id' => 'transactions#iframe', via: :get, as: :buy_iframe
  resources :stripe_events, only: [:create]
  resources :sales

  get '/comment' => 'comment#create', :as => 'comments'
  get '/rate' => 'rater#create', :as => 'rate'
  resources :searches, only: [:new, :create, :index]
  resources :exchanges  do
    member do
      put 'claim'
      put 'confirm'
    end
  end

  resources :users do
    resources :favorites
      member do
        post 'favorite'
      end  
  end
  
  get 'account' => 'welcome#account'
  root 'welcome#index'
  resource :session, only: [:destroy, :create, :new]

end
